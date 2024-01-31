// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../lib/forge-std/src/Script.sol";
import {ErrorHandler} from "../src/libraries/ErrorHandler.sol";

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

  modifier log(string memory description) {
    _log(description);
    _;
  }

  function run(bytes calldata callData) external {
    (bool success, bytes memory data) = address(this).delegatecall(callData);
    success.handleRevert(msg.sig, data);
    _postCheck();
  }

  function _postCheck() internal pure virtual {}

  function _log(string memory description) internal pure {
    string memory formattedLog = string.concat("> ", description, "...");
    console2.log(StdStyle.blue(formattedLog));
  }
}
