require("@nomicfoundation/hardhat-toolbox");
require("@moved/hardhat-plugin");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  defaultNetwork: process.env.NETWORK || "creditTestnet",
  networks: {
    // Credit Testnet configuration
    creditTestnet: {
      url: process.env.CREDIT_RPC_URL || "https://rpc.testnet.creditcoin.network", // placeholder
      chainId: process.env.CREDIT_CHAIN_ID ? Number(process.env.CREDIT_CHAIN_ID) : 0,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      timeout: 300000,
    },
    // Local development network
    localhost: {
      url: "http://127.0.0.1:8545",
      chainId: 31337,
    },
    // Hardhat network for testing
    hardhat: {
      chainId: 31337,
    },
  },
  etherscan: {
    apiKey: {
      creditTestnet: process.env.CREDITSCAN_API_KEY || "",
    },
    customChains: [
      {
        network: "creditTestnet",
        chainId: process.env.CREDIT_CHAIN_ID ? Number(process.env.CREDIT_CHAIN_ID) : 0,
        urls: {
          apiURL: process.env.CREDITSCAN_API_URL || "",
          browserURL: process.env.CREDIT_EXPLORER_URL || "",
        }
      }
    ]
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
};