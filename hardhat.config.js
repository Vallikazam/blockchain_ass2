require('@nomicfoundation/hardhat-ethers');

module.exports = {
  solidity: "0.8.28", 
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545",
      accounts: [`0x9397a6a11b69fd3aaa8bb7ff70aeaab78a3cfa8d8381abff1ad01d1d75b1a1f9`] 
    }
  }
};