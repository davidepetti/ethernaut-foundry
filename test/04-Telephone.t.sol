// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {TelephoneFactory} from "../src/04-Telephone/TelephoneFactory.sol";
import {TelephoneAttack} from "../src/04-Telephone/TelephoneAttack.sol";

contract TelephoneTest is Test {
    Ethernaut public ethernaut;
    address public user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_TelephoneAttack() public {
        // SETUP
        TelephoneFactory telephoneFactory = new TelephoneFactory();
        ethernaut.registerLevel(telephoneFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance(telephoneFactory);

        // ATTACK
        TelephoneAttack telephoneAttack = new TelephoneAttack(levelAddress);
        telephoneAttack.attack();

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
