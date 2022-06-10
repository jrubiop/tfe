const Pieza = artifacts.require("Pieza");
const Colaborador = artifacts.require("Colaborador");

module.exports = function (deployer) {
  deployer.deploy(Pieza);
  deployer.deploy(Colaborador);
  //deployer.deploy(CoinCrowdsale, startTime, endTime, rate, wallet)
};

