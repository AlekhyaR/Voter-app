// artifacts represents the our smart contract and truffle expose this to interact with in any case we want to  
var Election = artifacts.require("./Election.sol");

// we added a directive to deploy our contract with this function
module.exports = function(deployer) {
  deployer.deploy(Election);
};
