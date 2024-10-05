// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {CommonBase} from "../lib/forge-std/src/Base.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {StdChains} from "../lib/forge-std/src/StdChains.sol";
import {StdCheatsSafe} from "../lib/forge-std/src/StdCheats.sol";
import {StdUtils} from "../lib/forge-std/src/StdUtils.sol";
import {AccountFactory} from "../src/AccountFactory.sol";
import {IEntryPoint} from "@account-abstraction/interfaces/IEntryPoint.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address entryPoint = vm.envAddress("ENTRY_POINT_CONTRACT_ADDRESS");
        new AccountFactory(msg.sender, IEntryPoint(entryPoint));
        vm.stopBroadcast();
    }
}
