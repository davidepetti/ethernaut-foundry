// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Level} from "../core/Level.sol";
import {Fallback} from "./Fallback.sol";

contract FallbackFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        Fallback instance = new Fallback();
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player) public override returns (bool) {
        Fallback instance = Fallback(_instance);
        return instance.owner() == _player && address(instance).balance == 0;
    }
}
