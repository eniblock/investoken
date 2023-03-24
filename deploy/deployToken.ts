import {HardhatRuntimeEnvironment} from 'hardhat/types';
import { ethers, upgrades } from 'hardhat';

const func = async function (hre: HardhatRuntimeEnvironment) {
  const {getNamedAccounts} = hre;
  const {admin} = await getNamedAccounts();

  const Investoken = await ethers.getContractFactory("Investoken");
  const investoken = await upgrades.deployProxy(Investoken, [admin], { kind: 'uups' });
  await investoken.deployed();

  console.log("Token address:", investoken.address)
};
export default func;
func.tags = ['Investoken'];