// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {PreservationFactory} from "../src/16-Preservation/PreservationFactory.sol";
import {PreservationAttack} from "../src/16-Preservation/PreservationAttack.sol";

contract PreservationTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_PreservationAttack() public {
        // SETUP
        PreservationFactory preservationFactory = new PreservationFactory();
        ethernaut.registerLevel(preservationFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(preservationFactory);

        // ATTACK
        vm.roll(5);
        PreservationAttack preservationAttack = new PreservationAttack(levelAddress);
        preservationAttack.attack();

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
