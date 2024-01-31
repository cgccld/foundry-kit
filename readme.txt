My minimal deployment kit.

INSTALLATION
$ forge install --no-commit tasibii/minimal-deployment-kit

RUN
$ forge script --sig 'run(bytes)' ${calldata} -f $network --etherscan-api-key $network-api-key --private-key $deployer-pk -vv

-tasibii