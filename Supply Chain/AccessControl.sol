// File: AccessControl.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";

contract AccessControl is SupplyChain {
// Modifiers
modifier onlyManufacturer() {
require(isManufacturer[msg.sender], "Only manufacturer allowed");
_;
}
modifier onlyDistributor() {
    require(isDistributor[msg.sender], "Only distributor allowed");
    _;
}

modifier onlyRetailer() {
    require(isRetailer[msg.sender], "Only retailer allowed");
    _;
}
}