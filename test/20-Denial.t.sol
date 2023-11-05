// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {DenialFactory} from "../src/20-Denial/DenialFactory.sol";
import {Denial} from "../src/20-Denial/Denial.sol";
import {DenialAttack} from "../src/20-Denial/DenialAttack.sol";

contract DenialTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_DenialAttack() public {
        // SETUP
        DenialFactory denialFactory = new DenialFactory();
        ethernaut.registerLevel(denialFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance{value: 1 ether}(denialFactory);
        Denial ethernautDenial = Denial(payable(levelAddress));

        // ATTACK
        DenialAttack denialAttack = new DenialAttack();
        ethernautDenial.setWithdrawPartner(address(denialAttack));

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
