// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleNFT {
    uint256 public totalSupply;
    mapping(uint256 => address) public ownerOf;

    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    function mint(address to, uint256 tokenId) external {
        require(ownerOf[tokenId] == address(0), "Token already minted");
        ownerOf[tokenId] = to;
        totalSupply++;
        emit Transfer(address(0), to, tokenId);
    }
}