// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IEntryPoint} from "@account-abstraction/interfaces/IEntryPoint.sol";
import {AccountFactory} from "../lib/account-factory/src/AccountFactory.sol";
import {Test} from "../lib/forge-std/src/Test.sol";
import {PaymentHandler} from "../src/PaymentHandler.sol";

contract PaymentHandlerTest is Test {
    PaymentHandler public paymentHandler;
    address private alice = makeAddr("alice");
    address private bob = makeAddr("bob");

    function setUp() public {
        AccountFactory accountFactory = new AccountFactory(address(1),IEntryPoint(address(alice)));
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

    function testRequestTransfer() public {
        uint256 code = paymentHandler.requestTransfer(1);
        assertEq(code, 435232);
    }

    function testReadCodeToValue() public {
        uint256 code = paymentHandler.requestTransfer(1);
        uint256 value = paymentHandler.readCodeToValue(code);
        assertEq(value, 1);
    }

    function testFulfillCode() public {
        vm.startPrank(bob);
        uint256 code = paymentHandler.requestTransfer(1);
        vm.deal(alice, 1);
        uint256 aliceBalanceBeforeSend = alice.balance;
        uint256 bobBalanceBeforeSend = bob.balance;
        vm.startPrank(alice);
        paymentHandler.fulfillCode{value: 1}(code);

        assertEq(bobBalanceBeforeSend, 0);
        assertEq(aliceBalanceBeforeSend, 1);

        assertEq(bob.balance, 1);
        assertEq(alice.balance, 0);
    }

}
