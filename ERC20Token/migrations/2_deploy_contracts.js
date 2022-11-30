var ERC20Miner= artifacts.require("ERC20Miner");

module.exports = function(deployer) {
    deployer.deploy(ERC20Miner);
  };