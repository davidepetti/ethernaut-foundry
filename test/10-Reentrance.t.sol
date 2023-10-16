// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {ReentranceFactory} from "../src/10-Reentrance/ReentranceFactory.sol";
import {ReentranceAttack} from "../src/10-Reentrance/ReentranceAttack.sol";

contract ReentranceTest is Test {
    Ethernaut public ethernaut;
    address public attacker = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.label(attacker, "attacker");
        vm.deal(attacker, 5 ether);
    }

    function test_ReentranceAttack() public {
        // SETUP
        ReentranceFactory reentranceFactory = new ReentranceFactory();
        ethernaut.registerLevel(reentranceFactory);
        vm.startPrank(attacker);
        address levelAddress = ethernaut.createLevelInstance{value: 1 ether}(reentranceFactory);

        // ATTACK
        ReentranceAttack reentranceAttack = new ReentranceAttack(levelAddress);
        reentranceAttack.attack{value: 0.4 ether}();

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
