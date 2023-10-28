// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Level} from "../core/Level.sol";
import {GatekeeperTwo} from "./GatekeeperTwo.sol";

contract GatekeeperTwoFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        GatekeeperTwo instance = new GatekeeperTwo();
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player) public override returns (bool) {
        GatekeeperTwo instance = GatekeeperTwo(_instance);
        return instance.entrant() == _player;
    }
}
