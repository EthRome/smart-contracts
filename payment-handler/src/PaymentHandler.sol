// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AccountFactory} from "../lib/account-factory/src/AccountFactory.sol";

struct CodeValue {
    address to;
    uint256 value;
}

contract PaymentHandler {
    AccountFactory public accountFactory;

    address private mockedOwner = address(0);
    mapping (uint256 => CodeValue) public codeToValue;
    uint256 public codeNonce = 435231;

    constructor(AccountFactory _accountFactory){
        accountFactory = _accountFactory;
    }

    function requestTransfer(uint256 value) public returns (uint256) {
        codeNonce++;
        codeToValue[codeNonce] = CodeValue(msg.sender, value);
        return codeNonce;
    }

    function readCodeToValue(uint256 code) public view returns (uint256) {
        return codeToValue[code].value;
    }

    function fulfillCode(uint256 code) payable public {
        CodeValue memory codeValue = codeToValue[code];
        uint256 value = codeValue.value;
        if (value > msg.value) {
            revert("Insufficient value");
        }
        (bool sent, bytes memory _data) = codeValue.to.call{value: value}("");
        require(sent, "Failed to send Ether");
    }

    function forwardSend(address payable to, bytes32 toEmailHash) payable public {
        if (to != address(0)) {
            (bool sent, bytes memory _data) = to.call{value: msg.value}("");
            require(sent, "Failed to send Ether");
        }else{
            require(to == address(0) && uint256(toEmailHash) != 0);

            //Calculate deterministic address
            address contractAddress = accountFactory.getAddress(mockedOwner, uint256(toEmailHash));
            //Send ether
            (bool sent, bytes memory _data) = contractAddress.call{value: msg.value}("");
            require(sent, "Failed to send Ether");
        }
    }

}
