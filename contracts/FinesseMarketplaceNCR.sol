// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./NonCopyRight.sol";

/*
 * @title NFT Marketplace
 * @author astro
 */

contract FinesseCratorNCR {
    NonCopyRight NCR;
    address public ControllorAddr;
    address public ContractAddress;
    struct creatorCollection {
        uint256 numOfCollectionCreated;
        crators[] collectionCreated;
    }

    struct crators {
        address Creator;
        address Contract;
        uint8 collectiontype;
    }

    mapping(address => creatorCollection) public s_creatorCollection;

    constructor() {
        ControllorAddr = msg.sender;
        setAddress();
    }

    modifier isControllor() {
        ControllorAddr = msg.sender;
        _;
    }

    /*
     * @notice Method for listing NFT
     * @param nftAddress Address of NFT contract
     * @param tokenId Token ID of NFT
     * @param price sale price for each item
     */
    function setAddress() private {
        ContractAddress = address(this);
    }

    function createNonCopyRightCollection(string memory _name, address crator)
        external
        isControllor
        returns (
            address,
            address,
            uint256
        )
    {
        address newContractAddress;
        address creator;
        NCR = new NonCopyRight(_name);
        newContractAddress = NCR.NonCopyRightContractAddress();
        creator = crator;
        s_creatorCollection[crator].numOfCollectionCreated++;
        crators memory Crators = crators(crator, newContractAddress, 0);
        s_creatorCollection[crator].collectionCreated.push(Crators);
        return (creator, newContractAddress, 0);
    }

    function getresponse(uint256 noOfContract, address contractOwner)
        public
        view
        returns (
            address,
            address,
            uint256
        )
    {
        address a = s_creatorCollection[contractOwner].collectionCreated[noOfContract].Creator;
        address b = s_creatorCollection[contractOwner].collectionCreated[noOfContract].Contract;
        uint256 c = s_creatorCollection[contractOwner]
            .collectionCreated[noOfContract]
            .collectiontype;
        return (a, b, c);
    }
}
