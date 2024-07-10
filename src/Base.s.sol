// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@forge-std-1.9.1/src/Script.sol";

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
        string memory formattedLog = string.concat(unicode"📢 ", description);
        console2.log(StdStyle.blue(formattedLog));
    }

    function _explorerUrl() internal view returns (string memory) {
        uint256 chainId = block.chainid;

        // etherscan
        if (chainId == 1) return "https://etherscan.io/";
        if (chainId == 11155111) return "https://sepolia.etherscan.io/";
        // bscscan
        if (chainId == 56) return "https://bscscan.com/";
        if (chainId == 97) return "https://testnet.bscscan.com/";
        // polygon
        if (chainId == 137) return "https://polygonscan.com/";
        if (chainId == 80002) return "https://amoy.polygonscan.com/";
        // avalanche
        if (chainId == 43114) return "https://snowtrace.io/";
        if (chainId == 43113) return "https://testnet.snowtrace.io/";
        // op
        if (chainId == 10) return "https://optimistic.etherscan.io/";
        if (chainId == 11155420)
            return "https://sepolia-optimism.etherscan.io/";
        // arbitrum
        if (chainId == 42161) return "https://arbiscan.io/";
        if (chainId == 421614) return "https://sepolia.arbiscan.io/";
        else return "";
    }
}
