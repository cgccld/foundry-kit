// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Base.s.sol";

abstract contract BaseDeploy is BaseScript {
    bytes public EMPTY_ARGS;

    function deploy(
        string memory filename,
        bytes memory args
    ) public returns (address contractAddress) {
        vm.resumeGasMetering();
        contractAddress = deployCode(filename, args);
        vm.pauseGasMetering();
    }
}
