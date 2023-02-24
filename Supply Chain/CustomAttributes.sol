// File: CustomAttributes.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";
import "./ProductManagement.sol";

contract CustomAttributes is ProductManagement {
// Product attributes
mapping(uint => uint) public weights;
mapping(uint => uint) public dimensions;
mapping(uint => uint) public expirations;
// Environmental monitoring
mapping(uint => uint) public temperatures;
mapping(uint => uint) public humidities;

// Set product weight
function setProductWeight(uint _id, uint _weight) public onlyManufacturer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    weights[_id] = _weight;
}

// Set product dimensions
function setProductDimensions(uint _id, uint _height, uint _width, uint _depth) public onlyManufacturer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    dimensions[_id] = _height * 10000 + _width * 100 + _depth;
}

// Set product expiration date
function setProductExpiration(uint _id, uint _expiration) public onlyManufacturer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    expirations[_id] = _expiration;
}

// Set temperature reading
function setTemperature(uint _id, uint _temperature) public onlyManufacturer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    temperatures[_id] = _temperature;
}

// Set humidity reading
function setHumidity(uint _id, uint _humidity) public onlyManufacturer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    humidities[_id] = _humidity;
}
}
