// File: InventoryManagement.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";
import "./ProductManagement.sol";

contract InventoryManagement is ProductManagement {
// Inventory management
mapping(address => uint[]) public inventory;
// Add product to inventory
function addToInventory(uint _id) public onlyDistributor {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    Product storage product = products[_id];
    require(product.verified && !product.delivered, "Product not verified or already delivered");
    inventory[distributor].push(_id);
    product.distributor = distributor;
    product.state = 1;
}

// Remove product from inventory
function removeFromInventory(uint _id) public onlyDistributor {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    Product storage product = products[_id];
    require(product.distributor == distributor && !product.delivered, "Product not in inventory or already delivered");
    for (uint i = 0; i < inventory[distributor].length; i++) {
        if (inventory[distributor][i] == _id) {
            inventory[distributor][i] = inventory[distributor][inventory[distributor].length - 1];
            inventory[distributor].pop();
            break;
        }
    }
    product.state = 2;
}

// Get inventory
function getInventory() public view returns (uint[] memory) {
    return inventory[distributor];
}
}