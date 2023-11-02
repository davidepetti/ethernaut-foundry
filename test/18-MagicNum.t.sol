// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {MagicNumFactory} from "../src/18-MagicNumber/MagicNumFactory.sol";
import {MagicNum} from "../src/18-MagicNumber/MagicNum.sol";

contract MagicNumSolver {
    uint8 public whatIsTheMeaningOfLife = 42;
}

contract MagicNumTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_MagicNumAttack() public {
        // SETUP
        MagicNumFactory magicNumFactory = new MagicNumFactory();
        ethernaut.registerLevel(magicNumFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(magicNumFactory);
        MagicNum ethernautMagicNum = MagicNum(levelAddress);

        // ATTACK
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        assembly {
            addr := create(0, add(bytecode, 0x20), 0x13)
        }

        ethernautMagicNum.setSolver(addr);

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
