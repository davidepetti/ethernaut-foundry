// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Level} from "../core/Level.sol";
import {Instance} from "./Instance.sol";

contract InstanceFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        return address(new Instance('ethernaut0'));
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool) {
        _player;
        Instance instance = Instance(_instance);
        return instance.getCleared();
    }
}
