// File: ProductManagement.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";

contract ProductManagement is SupplyChain {
// Create a new product
function createProduct(string memory _name, uint _price) public onlyManufacturer returns (uint) {
// Increment product count
productCount++;

// Create new product
products[productCount] = Product(productCount, _name, _price, manufacturer, address(0), address(0), 0, false, false, block.timestamp);

// Emit event
emit ProductCreated(productCount, _name, _price, block.timestamp);

return productCount;
}

// Track a product
function trackProduct(uint _id) public view returns (Product memory) {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    return products[_id];
}

// Verify a product
function verifyProduct(uint _id) public onlyDistributor {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    Product storage product = products[_id];
    require(!product.verified, "Product already verified");
    product.verified = true;
    product.timestamp = block.timestamp;
    emit ProductVerified(_id, block.timestamp);
}

// Add a new participant to the supply chain
function addParticipant(address _participant) public onlyManufacturer {
    require(!participants[_participant], "Participant already exists");
    participants[_participant] = true;
    if (isDistributor[_participant]) {
        distributor = _participant;
    } else if (isRetailer[_participant]) {
        retailer = _participant;
    }
}

// Remove a participant from the supply chain
function removeParticipant(address _participant) public onlyManufacturer {
    require(participants[_participant], "Participant does not exist");
    participants[_participant] = false;
    if (distributor == _participant) {
        distributor = address(0);
    } else if (retailer == _participant) {
        retailer = address(0);
    }
}
}
