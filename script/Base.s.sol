// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../lib/forge-std/src/Script.sol";
import {ErrorHandler} from "src/libraries/ErrorHandler.sol";

interface IScript {
  function run(bytes calldata callData) external;
}

abstract contract BaseScript is Script, IScript {
  using ErrorHandler for *;

  modifier broadcast() {
    vm.startBroadcast();
    _;
    vm.stopBroadcast();
  }

  modifier logFn(string memory functionName) {
    _logFn(functionName);
    _;
  }

  function run(bytes calldata callData) external {
    (bool success, bytes memory data) = address(this).delegatecall(callData);
    success.handleRevert(msg.sig, data);
    _postCheck();
  }

  function _postCheck() internal pure virtual {}

  function _logFn(string memory functionName) internal pure {
    string memory log = string.concat("> ", functionName, "...");
    console2.log(StdStyle.blue(log));
  }
}
