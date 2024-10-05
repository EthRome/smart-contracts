// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PaymentHandler} from "../src/PaymentHandler.sol";
import {AccountFactory} from "../lib/account-factory/src/AccountFactory.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address accountFactoryAddress = vm.envAddress("ACCOUNT_FACTORY_ADDRESS");
        PaymentHandler ph = new PaymentHandler(AccountFactory(accountFactoryAddress));
        vm.stopBroadcast();
    }
}
