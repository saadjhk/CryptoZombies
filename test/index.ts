import { expect } from "chai";
import { ethers } from "hardhat";

describe("ZombieFactory", function () {
  it("Should create a zombie", async function () {
    const ZFactory = await ethers.getContractFactory("ZombieFactory");
    const zFactory = await ZFactory.deploy();
    await zFactory.deployed();

    await zFactory.generateRandomZombie("Saad");
    const zombie = await zFactory.zombies(1);

    console.log(zombie)
    expect(zombie.name).to.be.equal("Saad");
  });
});
