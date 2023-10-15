// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Level} from "../core/Level.sol";
import {Vault} from "./Vault.sol";

contract VaultFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        bytes32 password = "A very strong secret password :)";
        Vault instance = new Vault(password);
        return address(instance);
    }

    function validateInstance(address payable _instance, address) public override returns (bool) {
        Vault instance = Vault(_instance);
        return !instance.locked();
    }
}
