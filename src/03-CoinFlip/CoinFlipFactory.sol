// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Level} from "../core/Level.sol";
import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        return address(new CoinFlip());
    }

    function validateInstance(address payable _instance, address) public override returns (bool) {
        CoinFlip instance = CoinFlip(_instance);
        return instance.consecutiveWins() >= 10;
    }
}
