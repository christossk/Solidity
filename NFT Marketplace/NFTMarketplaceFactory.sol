// File: NFTMarketplaceFactory.sol

pragma solidity ^0.8.0;

import "./NFT.sol";
import "./NFTMarketplace.sol";

contract NFTMarketplaceFactory {
    
    event NFTMarketplaceCreated(address nftAddress, address marketplaceAddress);
    
    function createMarketplace(string memory nftName, string memory nftSymbol) external returns (address, address) {
        NFT nft = new NFT(nftName, nftSymbol);
        NFTMarketplace marketplace = new NFTMarketplace();
        nft.safeTransferFrom(msg.sender, address(marketplace), 0);
        marketplace.addNFT(address(nft));
        
        emit NFTMarketplaceCreated(address(nft), address(marketplace));
        
        return (address(nft), address(marketplace));
    }
}
