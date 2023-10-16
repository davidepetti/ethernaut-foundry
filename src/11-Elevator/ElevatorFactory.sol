// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Level} from "../core/Level.sol";
import {Elevator} from "./Elevator.sol";

contract ElevatorFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        Elevator instance = new Elevator();
        return address(instance);
    }

    function validateInstance(address payable _instance, address) public override returns (bool) {
        Elevator elevator = Elevator(_instance);
        return elevator.top();
    }
}
