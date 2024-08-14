import { expect } from "chai";
import hre from "hardhat";

describe('Voting', function () {
    it("Owner should be able to vote and the vote count should increase", async function () {
        const [owner] = await hre.ethers.getSigners();

        // Deploy the contract with initial options
        const options = ["Option1", "Option2", "Option3"];
        const Voting = await hre.ethers.getContractFactory("Voting");
        const voting = await Voting.deploy(options);
        // await voting.deployed();

        // Owner votes for Option1
        await voting.connect(owner).vote("Option1");

        // Verify that Option1's vote count is now 1
        const voteCount = await voting.getVotes("Option1");
        expect(voteCount).to.equal(1);
    });
});
