// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AccountFactory} from "../lib/account-factory/src/AccountFactory.sol";

contract PaymentHandler {
    AccountFactory public accountFactory;

    constructor(AccountFactory _accountFactory){
        accountFactory = _accountFactory;
    }

    function forwardSend(uint256 ethValue, address payable to, address factoryOwner, bytes32 toEmailHash) public {
        if (to != address(0)) {
            (bool sent, bytes memory _data) = to.call{value: ethValue}("");
            require(sent, "Failed to send Ether");
        }

        require(to == address(0) && uint256(toEmailHash) != 0);

        //Calculate deterministic address
        address contractAddress = accountFactory.getAddress(factoryOwner, uint256(toEmailHash));
        if (contractAddress != address(0)) {
            //Send ether
            (bool sent, bytes memory _data) = contractAddress.call{value: ethValue}("");
            require(sent, "Failed to send Ether");
        }

    }

}
