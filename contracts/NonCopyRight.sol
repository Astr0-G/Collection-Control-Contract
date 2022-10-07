// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract NonCopyRight is ERC1155, Ownable, ERC1155Burnable {
    address public NonCopyRightContractAddress;

    constructor(string memory _name,address owner) ERC1155(_name) {
        setAddress();
        transferOwnership(owner);
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
    function setAddress() private {
        NonCopyRightContractAddress = address(this);
    }
    function mint(address account, uint256 amount, uint256 itemID) public onlyOwner {
        
        _mint(account, itemID, amount, "");
    }
}
