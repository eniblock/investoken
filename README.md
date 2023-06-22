# Investoken

This is a Solidity smart contract project for Investoken. The project aims to deploy the Investoken (IVTK) with hardhat

## Prerequisites

- Node.js v12 or later
- Yarn package manager

## Installation

1. Clone this repository:
```
git clone git@github.com:eniblock/investoken.git
```

2. Install dependencies:
```
yarn install
```

## Usage

### Compilation

To compile the smart contracts, run the following command:
```
yarn compile
```

This will compile the contracts using Hardhat.

### Deployment

To deploy the contracts to a network, run the following command:
```
yarn deploy:[network name]
```

Replace [network name] with the name of the network you want to deploy to (e.g. goerli, mainnet, polygon, mumbai etc.).

### Local development

To start a local development chain, run the following command:
```
yarn chain
```

This will start a Hardhat node on your local machine.

### Testing

To run the tests, run the following command:
```
yarn test
```

### Coverage

To generate a code coverage report, run the following command:
```
yarn coverage
```

This will generate a coverage report for the contracts.

### Documentation

To generate documentation for the contracts, run the following command:
```
yarn dodoc
```

This will generate documentation using Solidity Natural Docs.

## License
The project are licensed under the MIT License (more information in the LICENSE file)
