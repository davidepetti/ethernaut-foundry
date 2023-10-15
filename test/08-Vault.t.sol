// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {VaultFactory} from "../src/08-Vault/VaultFactory.sol";
import {Vault} from "../src/08-Vault/Vault.sol";

contract VaultTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_ForceAttack() public {
        // SETUP
        VaultFactory vaultFactory = new VaultFactory();
        ethernaut.registerLevel(vaultFactory);
        address levelAddress = ethernaut.createLevelInstance(vaultFactory);
        Vault ethernautVault = Vault(levelAddress);

        // ATTACK
        // Using the cheatcode I read the storage at slot 1
        bytes32 password = vm.load(levelAddress, bytes32(uint256(1)));
        ethernautVault.unlock(password);

        // SUBMIT
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
