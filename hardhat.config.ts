import "@nomicfoundation/hardhat-toolbox";
import '@primitivefi/hardhat-dodoc';
import '@typechain/hardhat';
import 'hardhat-deploy';
import {task} from 'hardhat/config';
import {HardhatUserConfig} from 'hardhat/types';
import "@nomiclabs/hardhat-solhint";
import "@openzeppelin/hardhat-upgrades";
import "@nomiclabs/hardhat-etherscan";
import 'dotenv/config';
import * as dotenv from 'dotenv';
dotenv.config();

task('accounts', 'Prints the list of accounts', async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

const default_mnemonic = "announce room limb pattern dry unit scale effort smooth jazz weasel alcohol";

const defaultNetwork = "hardhat";

export default <HardhatUserConfig>{
  defaultNetwork,
  solidity: {
    compilers: [
      {
        version: '0.8.17',
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  namedAccounts: {
    admin: {
      default: 0,
      "mumbai": "0xBA3839604E9F3a01a52a2FCaF4517250a3a656E5",
      "polygon": "0xBA3839604E9F3a01a52a2FCaF4517250a3a656E5",
      "goerli": "0xBD685b882Cab5c11C7b11Fde420C1BDF249c588C"
    }
  },
  networks: {
    localhost: {
        url: "http://localhost:8545",
        accounts: {
          mnemonic: process.env.MNEMONIC ?? default_mnemonic,
        },
    },
    hardhat: {
        accounts: {
          mnemonic: process.env.MNEMONIC ?? default_mnemonic,
        },
    },
    mainnet: {
        url: "https://mainnet.infura.io/v3/" + process.env.API_KEY,
        accounts: {
          mnemonic: process.env.MNEMONIC ?? default_mnemonic,
        },
    },
    goerli: {
        url: "https://goerli.infura.io/v3/" + process.env.API_KEY,
        accounts: {
          mnemonic: process.env.MNEMONIC ?? default_mnemonic,
        },
    },
    polygon: {
        url: "https://polygon-rpc.com" + process.env.API_KEY,
        accounts: {
          mnemonic: process.env.MNEMONIC ?? default_mnemonic,
        },
    },
    mumbai: {
        url: "https://rpc-mumbai.maticvigil.com/",
        accounts: {
          mnemonic: process.env.MNEMONIC ?? default_mnemonic,
        },
    },
    matic: {
        url: "https://rpc-mainnet.maticvigil.com/" + process.env.API_KEY,
        accounts: {
          mnemonic: process.env.MNEMONIC ?? default_mnemonic,
        },
    },
},
paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  gasReporter: {
      currency: "USD",
      coinmarketcap: process.env.COINMARKETCAP,
      enabled: true,
  },
  mocha: {
    timeout: 0,
  },
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.ETHERSCAN_API_KEY as string,
      polygon: process.env.ETHERSCAN_API_KEY as string,
      goerli: process.env.ETHERSCAN_API_KEY as string,
    }
  },
}
