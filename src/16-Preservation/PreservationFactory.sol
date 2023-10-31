// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Level} from "../core/Level.sol";
import {Preservation, LibraryContract} from "./Preservation.sol";

contract PreservationFactory is Level {
    address timeZone1LibraryAddress;
    address timeZone2LibraryAddress;

    constructor() public {
        timeZone1LibraryAddress = address(new LibraryContract());
        timeZone2LibraryAddress = address(new LibraryContract());
    }

    function createInstance(address _player) public payable override returns (address) {
        _player;
        return address(new Preservation(timeZone1LibraryAddress, timeZone2LibraryAddress));
    }

    function validateInstance(address payable _instance, address _player) public override returns (bool) {
        Preservation preservation = Preservation(_instance);
        return preservation.owner() == _player;
    }
}
