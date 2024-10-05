// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../account-factory/src/AccountFactory.sol";

contract PaymentHandler {
    AccountFactory public accountFactory;

    constructor(AccountFactory _accountFactory){
        accountFactory = _accountFactory;
    }

    function forwardSend(uint256 ethValue, address payable to, address factoryOwner, byte32 toEmailHash) public {
        if(to != address(0)){
            to.call{value: ethValue}("");
        }

        require(to == address(0), toEmailHash != address(0));

        //Calculate deterministic address
        address contractAddress = accountFactory.getAddress();
        if(contractAddress != address(0)){
            //Send ether
            contractAddress.call{value: ethValue}("");
        }

    }

}
