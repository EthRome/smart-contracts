// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Base64} from "../src/Base64.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Base64 b = new Base64();
        vm.stopBroadcast();
    }
}
