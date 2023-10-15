// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {KingFactory} from "../src/09-King/KingFactory.sol";
import {KingAttack} from "../src/09-King/KingAttack.sol";

contract KingTest is Test {
    Ethernaut public ethernaut;
    address public user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(user, 5 ether);
    }

    function test_KingAttack() public {
        // SETUP
        KingFactory kingFactory = new KingFactory();
        ethernaut.registerLevel(kingFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance{value: 1 ether}(kingFactory);

        // ATTACK
        KingAttack kingAttack = (new KingAttack){value: 1 ether}(levelAddress);

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
