// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./FinesseMarketplaceCR.sol";
import "./FinesseMarketplaceNCR.sol";

/*
 * @title Finesse Marketplace Collection Controllor
 * @author astro
 */

contract FinesseCollectionControllor is ReentrancyGuard, Ownable {
    FinesseCratorCR CR;
    FinesseCratorNCR NCR;
    FinesseCratorCR public CRCrator;
    FinesseCratorNCR public NCRCrator;
    uint256 public TotalContractNum;
    uint256 public TotalNCRContract;
    uint256 public TotalCRContract;
    struct ownerstruct {
        address owner;
        uint8 typeofcollection;
    }
    mapping(address => ownerstruct) public collectionContractList;
    event CollectionCreated(
        address indexed creatoraddress,
        address indexed collectionaddress,
        uint256 indexed typeofcollection
    );

    constructor() {
        CR = new FinesseCratorCR();
        NCR = new FinesseCratorNCR();
        CRCrator = FinesseCratorCR(CR.ContractAddress());
        NCRCrator = FinesseCratorNCR(NCR.ContractAddress());
    }

    /*
     * @notice Method creating collection.
     * @param creating non-copyright collection.
     * @param creating copyright collection.
     * @param store all infos into contract.
     */

    function controllorCreateCopyRightCollection(string memory _name, string memory _symbol)
        external
    {
        (, address b, uint256 c) = CRCrator.createCopyRightCollection(_name, _symbol, msg.sender);
        TotalContractNum++;
        TotalCRContract++;
        ownerstruct memory OWS = ownerstruct(msg.sender, 1);
        collectionContractList[b] = OWS;
        emit CollectionCreated(msg.sender, b, c);
    }

    function controllorCreateNonCopyRightCollection(string memory _name) external {
        (, address b, uint256 c) = NCRCrator.createNonCopyRightCollection(_name, msg.sender);
        TotalContractNum++;
        TotalNCRContract++;
        ownerstruct memory OWS = ownerstruct(msg.sender, 0);
        collectionContractList[b] = OWS;
        emit CollectionCreated(msg.sender, b, c);
    }

    function getOwnerContractForNonCopyRight(uint256 noOfContract, address contractOwner)
        public
        view
        returns (address, uint256)
    {
        (, address b, uint256 c) = NCRCrator.getresponse(noOfContract, contractOwner);
        return (b, c);
    }

    function getOwnerContractForCopyRight(uint256 noOfContract, address contractOwner)
        public
        view
        returns (address, uint256)
    {
        (, address b, uint256 c) = CRCrator.getresponse(noOfContract, contractOwner);
        return (b, c);
    }

    function getOwnerNumContractOfCopyRight(address contractOwner) public view returns (uint256) {
        uint256 a = CRCrator.s_creatorCollection(contractOwner);
        return (a);
    }

    function getOwnerNumContractOfNonCopyRight(address contractOwner)
        public
        view
        returns (uint256)
    {
        uint256 a = NCRCrator.s_creatorCollection(contractOwner);
        return (a);
    }
}
