// File: SalesFeedback.sol
pragma solidity ^0.8.0;

import "./SupplyChain.sol";
import "./ProductManagement.sol";

contract SalesFeedback is ProductManagement {
// Sales and feedback
mapping(uint => bool) public sold;
mapping(uint => uint) public ratings;
mapping(uint => string) public reviews;
// Sell product to customer
function sellProduct(uint _id, uint _rating, string memory _review) public onlyRetailer {
    require(_id > 0 && _id <= productCount, "Invalid product ID");
    Product storage product = products[_id];
    require(product.verified && product.delivered && !sold[_id], "Product not verified, not delivered, or already sold");
    sold[_id] = true;
    ratings[_id] = _rating;
    reviews[_id] = _review;
    balances[retailer] += product.price / 2;
    balances[manufacturer] += product.price / 2;
    product.state = 3;
    emit ProductSold(_id, block.timestamp);
}
}