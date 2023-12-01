// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { IScript } from "./interfaces/IScript.sol";
import { ErrorHandler } from "./libraries/ErrorHandler.sol";
import { console2, Script } from "../lib/forge-std/src/Script.sol";

abstract contract BaseScript is Script, IScript {
    using ErrorHandler for *;

    modifier broadcast() {
        vm.startBroadcast();
        _;
        vm.stopBroadcast();
    }

    function run(bytes calldata callData) external {
        (bool success, bytes memory returnOrRevertData) = address(this).delegatecall(callData);
        success.handleRevert(returnOrRevertData);
    }
}
