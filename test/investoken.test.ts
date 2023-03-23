import { ethers, upgrades } from "hardhat";
import { expect } from "chai";

describe("Investoken tests", function () {
    beforeEach(async function () {
        const Investoken = await ethers.getContractFactory("Investoken");
        this.investoken = await upgrades.deployProxy(Investoken, [], { kind: 'uups' });
        await this.investoken.deployed();

    });

    it("Should force mint", async function () {
        await this.investoken.forceMint("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1", 100)
        console.log(await this.investoken.balanceOf("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1"));
        expect(await this.investoken.balanceOf("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1")).to.equal(100);
    });

    it("Should unpause", async function () {
        await this.investoken.unpause()
        expect(await this.investoken.paused()).to.equal(false);
    });

    it("Should snapshot", async function () {
        expect(await this.investoken.snapshot()).to.be.not.reverted;
    });

    it("Should mint", async function () {
        await this.investoken.unpause()
        await this.investoken.mint("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1", 100)
        expect(await this.investoken.balanceOf("0x71CB05EE1b1F506fF321Da3dac38f25c0c9ce6E1")).to.equal(100);
    });

    it("Should pause", async function () {
        await this.investoken.unpause()
        await this.investoken.pause()
        expect(await this.investoken.paused()).to.equal(true);
    });

});