// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {GatekeeperTwoFactory} from "../src/14-GatekeeperTwo/GatekeeperTwoFactory.sol";
import {GatekeeperTwoAttack} from "../src/14-GatekeeperTwo/GatekeeperTwoAttack.sol";

contract GatekeeperTwoTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_GatekeeperTwoAttack() public {
        // SETUP
        GatekeeperTwoFactory gatekeeperTwoFactory = new GatekeeperTwoFactory();
        ethernaut.registerLevel(gatekeeperTwoFactory);
        vm.prank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(gatekeeperTwoFactory);

        // ATTACK
        GatekeeperTwoAttack gatekeeperTwoAttack = new GatekeeperTwoAttack(levelAddress);

        // SUBMIT
        vm.prank(tx.origin);
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
