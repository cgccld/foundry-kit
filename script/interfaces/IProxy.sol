// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IProxy {
    function upgradeToAndCall(address implementation, bytes calldata data) external payable;
}
