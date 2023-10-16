// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {ElevatorFactory} from "../src/11-Elevator/ElevatorFactory.sol";
import {ElevatorAttack} from "../src/11-Elevator/ElevatorAttack.sol";

contract ElevatorTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_ReentranceAttack() public {
        // SETUP
        ElevatorFactory elevatorFactory = new ElevatorFactory();
        ethernaut.registerLevel(elevatorFactory);
        address levelAddress = ethernaut.createLevelInstance(elevatorFactory);

        // ATTACK
        ElevatorAttack elevatorAttack = new ElevatorAttack(levelAddress);
        elevatorAttack.attack();

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
