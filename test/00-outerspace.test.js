const { assert, expect } = require("chai")
const { network, deployments, ethers, getNamedAccounts } = require("hardhat")

describe("outerspace FinesseCollectionControllor Collection Control Test", () => {
    let player1
    let Staking
    let NFTMint
    let erc20

    beforeEach(async () => {
        deployer = (await getNamedAccounts()).deployer
        accounts = await ethers.getSigners()
        player1 = accounts[1]
        player2 = accounts[2]
        await deployments.fixture(["all"])
        Outerspace = await ethers.getContract("FinesseCollectionControllor")
    })

    it("created 3 copy right collection and verify 3 collections are created.", async () => {
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        let number = await Outerspace.getOwnerNumContractOfCopyRight(deployer)
        assert.equal(number.toString(), 3)
        console.log(`There are ${number.toString()} copy right contracts created `)
    })

    it("created 3 Non copy right collection and verify 3 collections are created.", async () => {
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        let number = await Outerspace.getOwnerNumContractOfNonCopyRight(deployer)
        assert.equal(number.toString(), 3)
        console.log(`There are ${number.toString()} non copy right contracts created `)
    })

    it("created 3 copy right collection and read 3 collections address for each.", async () => {
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        let number1 = await Outerspace.getOwnerNumContractOfCopyRight(deployer)
        for (let i = 0; i < number1.toString(); i++) {
            let number2 = await Outerspace.getOwnerContractForCopyRight(i, deployer)
            console.log(`No.${i+1} contract address is ${number2[0].toString()}, and its type is ${number2[1].toString()}`)
            assert.equal(number2[1].toString(),1)
        }
    })

    it("created 3 Non copy right collection and read 3 collections address for each.", async () => {
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        let number1 = await Outerspace.getOwnerNumContractOfNonCopyRight(deployer)
        for (let i = 0; i < number1.toString(); i++) {
            let number2 = await Outerspace.getOwnerContractForNonCopyRight(i, deployer)
            console.log(`No.${i+1} contract address is ${number2[0].toString()}, and its type is ${number2[1].toString()}`)
            assert.equal(number2[1].toString(),0)
        }
    })

    it("created 3 collection for each type and check total contracts created of each.", async () => {
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        await Outerspace.controllorCreateNonCopyRightCollection("abc")
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        await Outerspace.controllorCreateCopyRightCollection("abc", "eud")
        let number1 = await Outerspace.TotalContractNum()
        let number2 = await Outerspace.TotalNCRContract()
        let number3 = await Outerspace.TotalCRContract()
        assert.equal(number1.toString(),6)
        assert.equal(number2.toString(),3)
        assert.equal(number3.toString(),3)
    })

    it("created 1 collection for each type and check event trigger.", async () => {
        await expect(Outerspace.controllorCreateNonCopyRightCollection("abc")).to.emit(Outerspace, "CollectionCreated")        
        await expect(Outerspace.controllorCreateCopyRightCollection("abc", "eud")).to.emit(Outerspace, "CollectionCreated")        
    })

    it("created collection and check collection address from creator and from address.",async()=>{
        for (let i = 0; i < 10; i++) {
            await Outerspace.controllorCreateNonCopyRightCollection("abc")
            let number2 = await Outerspace.getOwnerContractForNonCopyRight(i, deployer)
            let number1 = await Outerspace.collectionContractList(number2[0].toString())
            assert.equal(number1[0].toString(),deployer)
        }
        
        
    })
})
