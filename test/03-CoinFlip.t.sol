// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {CoinFlipFactory} from "../src/03-CoinFlip/CoinFlipFactory.sol";
import {CoinFlipAttack} from "../src/03-CoinFlip/CoinFlipAttack.sol";

contract CoinFlipTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_CoinFlipAttack() public {
        // SETUP
        CoinFlipFactory coinFlipFactory = new CoinFlipFactory();
        ethernaut.registerLevel(coinFlipFactory);
        address levelAddress = ethernaut.createLevelInstance(coinFlipFactory);

        vm.roll(1);

        // ATTACK
        CoinFlipAttack coinFlipAttack = new CoinFlipAttack(levelAddress);
        for (uint256 i = 2; i <= 11; i++) {
            vm.roll(i);
            coinFlipAttack.attack();
        }

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
