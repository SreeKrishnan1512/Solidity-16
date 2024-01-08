// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyToken.sol";
import "./SimpleNFT.sol";

contract ProductStore {
    
    MyToken public token;
    SimpleNFT public billNFT;
    
    event ProductPurchased(address indexed buyer, uint256 productId, uint256 billId);

    struct Product {
        uint256 price;
        bool isAvailable;
    }

    mapping(uint256 => Product) public products;

    constructor() {
        token = new MyToken(1000000);  // Initial supply for the token
        billNFT = new SimpleNFT();
        // Initialize products
        products[1] = Product(0, true);
        products[2] = Product(0, true);
    }

    modifier isAvailable(uint256 productId) {
        require(products[productId].isAvailable, "Product not available");
        _;
    }

    function buyProduct(uint256 productId) external isAvailable(productId) {
        Product storage product = products[productId];
        require(token.transferFrom(msg.sender, address(this), product.price), "Token transfer failed");

        // Mint a bill NFT for the buyer
        uint256 billId = billNFT.totalSupply();
        billNFT.mint(msg.sender, billId);

        // Mark the product as sold
        product.isAvailable = false;

        emit ProductPurchased(msg.sender, productId, billId);
    }
}