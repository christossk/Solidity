// File: History.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";
import "./ProductManagement.sol";

contract History is ProductManagement {
// Get product history
function getProductHistory(uint _id) public view returns (uint[] memory, uint[] memory) {
require(_id > 0 && _id <= productCount, "Invalid product ID");
Product storage product = products[_id];
uint[] memory states = new uint;
uint[] memory timestamps = new uint;
for (uint i = 1; i <= productCount; i++) {
states[i - 1] = products[i].state;
timestamps[i - 1] = products[i].timestamp;
}
return (states, timestamps);
}
}