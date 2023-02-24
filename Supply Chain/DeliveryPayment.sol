// File: DeliveryPayment.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";
import "./ProductManagement.sol";

contract DeliveryPayment is ProductManagement {
// Deliver a product
function deliverProduct(uint _id) public onlyRetailer {
require(_id > 0 && _id <= productCount, "Invalid product ID");
Product storage product = products[_id];
require(product.verified, "Product not verified");
require(!product.delivered, "Product already delivered");
product.delivered = true;
product.timestamp = block.timestamp;
emit ProductDelivered(_id, block.timestamp);
// Release payment to manufacturer
uint amount = product.price;
(bool success, ) = manufacturer.call{value: amount}("");
require(success, "Failed to send payment");
emit PaymentReleased(manufacturer, amount, block.timestamp);
}
}
