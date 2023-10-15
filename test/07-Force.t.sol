// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {ForceFactory} from "../src/07-Force/ForceFactory.sol";
import {ForceAttack} from "../src/07-Force/ForceAttack.sol";

contract ForceTest is Test {
    Ethernaut public ethernaut;
    address public user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(user, 10 ether);
    }

    function test_ForceAttack() public {
        // SETUP
        ForceFactory forceFactory = new ForceFactory();
        ethernaut.registerLevel(forceFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance(forceFactory);

        // ATTACK
        ForceAttack forceAttack = new ForceAttack();
        address(forceAttack).call{value: 1 ether}("");
        forceAttack.attack(levelAddress);

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
