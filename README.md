# Boundry Deployment Kit

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/tasibii/boundry-deployment-kit/blob/main/LICENSE)

## Overview

"Bacoor-foundry" Deployment Kit is engineered for the deployment of Solidity smart contracts, offering a streamlined process with minimal scripting requirements.

## Features

- **Deploy non-proxy contract:** 
- **Deploy proxy contract:** (UUPS, Transparent)
- **Upgrade proxy contract:** (Openzeppelin's UUPSUpgradeable, TransparentUpgradeable)

## Getting Started

These instructions will help you obtain a copy of the project and set it up on the Foundry project.

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)

### Installation

```shell
forge install --no-commit tasibii/boundry-deployment-kit
```

## Usage
Sample script contract
```solidity
    // SPDX-License-Identifier: UNLICENSED
    pragma solidity ^0.8.22;

    import "boundry-deployment-kit/BaseDeploy.s.sol";
    import { Sample, SampleUUPS, SampleTransparent } from "src/Sample.sol";

    contract SampleDeploy is BaseDeploy {
        function _defaultAdmin() internal pure override returns (address _admin) {
            _admin = 0x0; // ProxyAdmin contract address
        }

        function deploySample()
            external
            broadcast
            returns (address payable deployed)
        {
            deployed = deployRaw("Sample.sol:Sample", abi.encode());
        }

        function deploySampleUUPS()
            external
            broadcast
            returns (address payable proxy)
        {
            switchKind(Kind.Uups);
            proxy = deployProxyRaw(
                "Sample.sol:SampleUUPS", abi.encodeCall(SampleUUPS.initialize, ())
            );
        }

        function deploySampleTransparent()
            external
            broadcast
            returns (address payable proxy)
        {
            switchKind(Kind.Transparent);
            proxy = deployProxyRaw(
                "Sample.sol:SampleTransparent",
                abi.encodeCall(SampleTransparent.initialize, ())
            );
        }

        function upgradeContract(address payable proxy) external broadcast {
            address logic = deployLogic("Sample.sol:SampleUUPS");
            switchKind(Kind.Uups);
            upgradeTo(proxy, logic);
        }
    }
```
Sample command run script 
```sh
    source .env

    # Read script
    echo Which script do you want to run?
    read script

    echo Enter the network to which you want to deploy:
    read network

    # example: cast calldata 'deploySample()'
    echo Enter calldata of target function:
    read calldata

    # Read script options
    echo Enter script options, or press enter if none:
    read opts

    # Run the script
    echo Running Script: $script...

    forge script $script \
        --sig 'run(bytes)' $(eval "$calldata") \
        -f $network \
        -vvvv \
        --etherscan-api-key $network \
        --private-key $DEPLOYER_KEY \
        $opts
```

## License
