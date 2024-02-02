// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import {ErrorHandler} from "../src/ErrorHandler.sol";


abstract contract BaseScript is Script {
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

  function _postCheck() internal pure virtual {}

  function _log(string memory description) internal pure {
    string memory formattedLog = string.concat("> ", description, "...");
    console2.log(StdStyle.blue(formattedLog));
  }
}
