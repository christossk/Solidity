// File: NFTMarketplace.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./NFT.sol";

contract NFTMarketplace is ERC721Holder, ReentrancyGuard {
    
    address public owner;

    struct Sale {
        uint256 tokenId;
        address seller;
        uint256 price;
        bool active;
    }

    Sale[] public sales;
    mapping(uint256 => uint256) public tokenSaleIds;

    event SaleCreated(uint256 saleId, uint256 tokenId, address seller, uint256 price);
    event SaleCancelled(uint256 saleId);
    event SaleSuccessful(uint256 saleId, address buyer, uint256 price);

    constructor() {
        owner = msg.sender;
    }

    function createSale(address nftAddress, uint256 tokenId, uint256 price) external {
        require(IERC721(nftAddress).ownerOf(tokenId) == msg.sender, "NFTMarketplace: Only NFT owners can create a sale");
        require(price > 0, "NFTMarketplace: Price should be greater than 0");

        Sale memory sale = Sale({
            tokenId: tokenId,
            seller: msg.sender,
            price: price,
            active: true
        });

        uint256 saleId = sales.length;
        sales.push(sale);
        tokenSaleIds[tokenId] = saleId;

        IERC721(nftAddress).safeTransferFrom(msg.sender, address(this), tokenId);

        emit SaleCreated(saleId, tokenId, msg.sender, price);
    }

    function cancelSale(uint256 saleId) external nonReentrant {
        Sale memory sale = sales[saleId];
        require(msg.sender == sale.seller, "NFTMarketplace: Only sellers can cancel a sale");
        require(sale.active, "NFTMarketplace: Sale is not active");

        NFT(nftAddress).safeTransferFrom(address(this), msg.sender, sale.tokenId);

        delete tokenSaleIds[sale.tokenId];
        delete sales[saleId];

        emit SaleCancelled(saleId);
    }

    function buy(address nftAddress, uint256 saleId) external payable nonReentrant {
        Sale memory sale = sales[saleId];
        require(sale.active, "NFTMarketplace: Sale is not active");
        require(msg.value == sale.price, "NFTMarketplace: Invalid price");

        IERC721(nftAddress).safeTransferFrom(address(this), msg.sender, sale.tokenId);

        delete tokenSaleIds[sale.tokenId];
        delete sales[saleId];

        (bool success, ) = sale.seller.call{value: msg.value}("");
        require(success, "NFTMarketplace: Unable to send ETH to seller");

        emit SaleSuccessful(saleId, msg.sender, sale.price);
    }

    function getSale(uint256 saleId) external view returns (Sale memory) {
        return sales[saleId];
    }

    function getSaleId(uint256 tokenId) external view returns (uint256) {
        return tokenSaleIds[tokenId];
    }
}
