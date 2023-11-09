// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IScript {
    function run(bytes calldata args) external;
}
