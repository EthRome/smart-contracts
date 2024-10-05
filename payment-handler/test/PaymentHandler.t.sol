// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IEntryPoint} from "@account-abstraction/interfaces/IEntryPoint.sol";
import {AccountFactory} from "../lib/account-factory/src/AccountFactory.sol";
import {Test} from "../lib/forge-std/src/Test.sol";
import {PaymentHandler} from "../src/PaymentHandler.sol";

contract PaymentHandlerTest is Test {
    PaymentHandler public paymentHandler;
    address private alice = makeAddr("alice");

    function setUp() public {
        AccountFactory accountFactory = new AccountFactory(address(0),IEntryPoint(address(0)));
        paymentHandler = new PaymentHandler(accountFactory);
    }

    function test_basic_send() public {
        address targetAddress = alice;
        bytes32 hashedEmail = keccak256("test.email@domain.com");
        paymentHandler.forwardSend(
            payable(targetAddress),
            hashedEmail
        );

    }

}
