import chai, { expect } from "chai";
import { ethers } from "hardhat";
import { solidity } from "ethereum-waffle";

chai.use(solidity);

describe("ZombieFactory", function () {
  it("Should create a zombie", async function () {
    const ZFactory = await ethers.getContractFactory("ZombieFactory");
    const zFactory = await ZFactory.deploy();
    await zFactory.deployed();

    await zFactory.generateRandomZombie("Saad");
    const zombie = await zFactory.zombies(0);

    expect(zombie[0]).to.be.equal("Saad");
  });

  it("Should create 1 zombie per user", async function () {
    const [owner, addr1] = await ethers.getSigners();

    const ZFactory = await ethers.getContractFactory("ZombieFactory");
    const zFactory = await ZFactory.deploy();
    await zFactory.deployed();

    zFactory.connect(addr1);
    await zFactory.generateRandomZombie("Saad");
    await expect(zFactory.generateRandomZombie("Saad")).to.be.reverted;
  });
});
