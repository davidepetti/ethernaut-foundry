// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Ethernaut} from "../src/core/Ethernaut.sol";
import {InstanceFactory} from "../src/00-Instance/InstanceFactory.sol";
import {Instance} from "../src/00-Instance/Instance.sol";

contract InstanceTest is Test {
    Ethernaut public ethernaut;
    InstanceFactory public instanceFactory;
    Instance public ethernautInstance;
    address public levelAddress;

    function setUp() public {
        ethernaut = new Ethernaut();
        instanceFactory = new InstanceFactory();
        ethernaut.registerLevel(instanceFactory);
        levelAddress = ethernaut.createLevelInstance(instanceFactory);
        ethernautInstance = Instance(levelAddress);
    }

    function test_InstanceAttack() public {
        // ATTACK
        console.log(ethernautInstance.info());
        console.log(ethernautInstance.info1());
        console.log(ethernautInstance.info2("hello"));
        console.log(ethernautInstance.infoNum());
        console.log(ethernautInstance.info42());
        console.log(ethernautInstance.theMethodName());
        console.log(ethernautInstance.method7123949());
        string memory password = ethernautInstance.password();
        console.log(password);
        ethernautInstance.authenticate(password);

        // SUBMISSION
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)), "level not solved");
    }
}
