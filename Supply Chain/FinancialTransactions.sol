// File: FinancialTransactions.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";
import "./ProductManagement.sol";

contract FinancialTransactions is ProductManagement {
// Financial transactions
mapping(uint => uint) public payments;
mapping(address => uint) public balances;
// Add funds to balance
function addFunds() public payable {
    balances[msg.sender] += msg.value;
}

// Release payment to distributor
function releasePayment(uint _id) public onlyManufacturer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    Product storage product = products[_id];
    require(product.verified && product.delivered, "Product not verified or delivered");
    require(!payments[_id], "Payment already released");
    payments[_id] = product.price / 2;
    balances[distributor] += payments[_id];
}

// Refund payment to retailer
function refundPayment(uint _id) public onlyManufacturer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    Product storage product = products[_id];
    require(!product.verified || !product.delivered, "Product already verified and delivered");
    require(payments[_id], "Payment not released");
    uint amount = payments[_id];
    payments[_id] = 0;
    (bool success, ) = retailer.call{value: amount}("");
    require(success, "Failed to send refund");
}
}
