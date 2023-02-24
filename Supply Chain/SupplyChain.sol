// File: SupplyChain.sol
pragma solidity ^0.8.0;

contract SupplyChain {
// State variables
address public manufacturer;
address public distributor;
address public retailer;
uint public productCount = 0;
mapping(uint => Product) public products;
mapping(address => bool) public participants;
mapping(address => bool) public isManufacturer;
mapping(address => bool) public isDistributor;
mapping(address => bool) public isRetailer;

// Events
event ProductCreated(uint indexed id, string name, uint price, uint timestamp);
event ProductVerified(uint indexed id, uint timestamp);
event ProductDelivered(uint indexed id, uint timestamp);
event PaymentReleased(address manufacturer, uint amount, uint timestamp);

// Structs
struct Product {
    uint id;
    string name;
    uint price;
    address manufacturer;
    address distributor;
    address retailer;
    uint state;
    bool verified;
    bool delivered;
    uint timestamp;
}

// Constructor
constructor(address _manufacturer) {
    manufacturer = _manufacturer;
    participants[_manufacturer] = true;
    isManufacturer[_manufacturer] = true;
}
}
