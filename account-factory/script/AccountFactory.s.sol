// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Script, console} from "forge-std/Script.sol";
import {AccountFactory} from "../src/AccountFactory.sol";
import {IEntryPoint} from "../lib/account-abstraction/contracts/interfaces/IEntryPoint.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address entryPoint = vm.envAddress("ENTRY_POINT_CONTRACT_ADDRESS");
        new AccountFactory(IEntryPoint(entryPoint));
        vm.stopBroadcast();
    }
}
