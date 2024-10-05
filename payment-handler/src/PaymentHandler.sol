// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AccountFactory} from "../lib/account-factory/src/AccountFactory.sol";

contract PaymentHandler {
    AccountFactory public accountFactory;

    address private mockedOwner = address(0);

    constructor(AccountFactory _accountFactory){
        accountFactory = _accountFactory;
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
