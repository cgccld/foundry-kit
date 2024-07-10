// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../lib/forge-std/src/Script.sol";

abstract contract BaseScript is Script {
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
