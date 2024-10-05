// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PaymentHandler} from "../src/PaymentHandler.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        PaymentHandler ph = new PaymentHandler();
        vm.stopBroadcast();
    }
}
