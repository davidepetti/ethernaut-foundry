// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {InstanceFactory} from "../src/00-Instance/InstanceFactory.sol";
import {Instance} from "../src/00-Instance/Instance.sol";

contract InstanceTest is Test {
    Ethernaut public ethernaut;

    function setUp() public {
        ethernaut = new Ethernaut();
    }

    function test_InstanceAttack() public {
        // SETUP
        InstanceFactory instanceFactory = new InstanceFactory();
        ethernaut.registerLevel(instanceFactory);
        address levelAddress = ethernaut.createLevelInstance(instanceFactory);
        Instance ethernautInstance = Instance(levelAddress);

        // ATTACK
        emit log(ethernautInstance.info());
        emit log(ethernautInstance.info1());
        emit log(ethernautInstance.info2("hello"));
        emit log_uint(ethernautInstance.infoNum());
        emit log(ethernautInstance.info42());
        emit log(ethernautInstance.theMethodName());
        emit log(ethernautInstance.method7123949());
        string memory password = ethernautInstance.password();
        emit log(password);
        ethernautInstance.authenticate(password);

        // SUBMISSION
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
