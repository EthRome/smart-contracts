// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IEntryPoint} from "../lib/account-factory/lib/account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {AccountFactory} from "../lib/account-factory/src/AccountFactory.sol";
import {Test} from "../lib/forge-std/src/Test.sol";
import {PaymentHandler} from "../src/PaymentHandler.sol";

contract PaymentHandlerTest is Test {
    PaymentHandler public paymentHandler;
    address private alice = makeAddr("alice");

    function setUp() public {
        AccountFactory accountFactory = new AccountFactory(IEntryPoint(address(0)));
        paymentHandler = new PaymentHandler(accountFactory);
    }

    function test_basic_send() public {
        address targetAddress = alice;
        address factoryOwner = address(0);
        bytes32 hashedEmail = keccak256("test.email@domain.com");
        paymentHandler.forwardSend(
            uint256(1),
            payable(targetAddress),
            factoryOwner,
            hashedEmail
        );

    }

}
