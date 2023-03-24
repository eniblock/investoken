import { ethers, upgrades } from "hardhat";
import { expect } from "chai";

describe("Investoken tests", function () {
    beforeEach(async function () {
        this.accounts = await ethers.getSigners();
        this.admin = this.accounts[0];
        this.notAdmin = this.accounts[1];

        const Investoken = await ethers.getContractFactory("Investoken");
        this.investoken = await upgrades.deployProxy(Investoken, [this.admin.address], { kind: 'uups' });
        await this.investoken.deployed();

    });

    it("Should mint without pause", async function () {
        await this.investoken.mint("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1", 100)
        expect(await this.investoken.balanceOf("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1")).to.equal(100);
    });

    it("Should revert mint with role error", async function () {
         await expect(this.investoken.connect(this.notAdmin).mint("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1", 100)).to.be.reverted;
    });

    it("Should mint with pause", async function () {
        await this.investoken.pause();
        await this.investoken.mint("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1", 100)
        expect(await this.investoken.balanceOf("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1")).to.equal(100);
    });

    it("Should pause and unpause", async function () {
        await this.investoken.pause();
        expect(await this.investoken.paused()).to.equal(true);
        await this.investoken.unpause()
        expect(await this.investoken.paused()).to.equal(false);
    });

    it("Should revert pause with role error", async function () {
        await expect(this.investoken.connect(this.notAdmin).pause()).to.be.reverted;
    });

    it("Should revert unpause with role error", async function () {
        this.investoken.pause();
        await expect(this.investoken.connect(this.notAdmin).unpause()).to.be.reverted;
    });

    it("Should snapshot", async function () {
        expect(await this.investoken.snapshot()).to.be.not.reverted;
    });

    it("Should revert snapshot with role", async function () {
        await expect(this.investoken.connect(this.notAdmin).snapshot()).to.be.reverted;
    });

    it("Should uppgrade", async function () {
        const Investoken = await ethers.getContractFactory("Investoken");
        const newInvestoken = await Investoken.deploy();
        await newInvestoken.deployed();
        await expect(this.investoken.upgradeTo(newInvestoken.address)).to.be.not.reverted;
    });

    it("Should revert uppgrade with role ", async function () {
        const Investoken = await ethers.getContractFactory("Investoken");
        const newInvestoken = await Investoken.deploy();
        await newInvestoken.deployed();
        await expect(this.investoken.connect(this.notAdmin).upgradeTo(newInvestoken.address)).to.be.reverted;
    });
});