// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./InsurancePolicy.sol";

contract InsuranceClaims is InsurancePolicy {
struct Claim {
bool isClaimed;
uint256 claimTime;
uint256 claimAmount;
}

Claim[] public claims;
uint256 public minTimeBetweenClaims;

constructor(uint256 _minTimeBetweenClaims) {
    minTimeBetweenClaims = _minTimeBetweenClaims;
}

function claim() internal {
    require(msg.sender == policyholder, "Only policyholder can claim payout.");
    require(block.timestamp < policyExpiration, "Policy has expired.");
    require(getCurrentClaimTime() >= minTimeBetweenClaims, "Too soon to file another claim.");
    uint256 claimAmount = policyPayout;
    require(address(this).balance >= claimAmount, "Insufficient funds to cover claim.");
    claims.push(Claim(true, block.timestamp, claimAmount));
    payPolicyholder(claimAmount);
}

function getClaimDetails(uint256 _claimNumber) internal view returns (bool, uint256) {
    require(_claimNumber < claims.length, "Invalid claim number.");
    Claim storage c = claims[_claimNumber];
    return (c.isClaimed, c.claimAmount);
}

function getNumberOfClaims() internal view returns (uint256) {
    return claims.length;
}

function getClaimAmount(uint256 _claimNumber) internal view returns (uint256) {
    require(_claimNumber < claims.length, "Invalid claim number.");
    Claim storage c = claims[_claimNumber];
    return c.claimAmount;
}

function getClaimTime(uint256 _claimNumber) internal view returns (uint256) {
    require(_claimNumber < claims.length, "Invalid claim number.");
    Claim storage c = claims[_claimNumber];
    return c.claimTime;
}

function setMinTimeBetweenClaims(uint256 _minTimeBetweenClaims) external {
    require(msg.sender == policyholder, "Only policyholder can change minimum time between claims.");
    minTimeBetweenClaims = _minTimeBetweenClaims;
}

function getMinTimeBetweenClaims() external view returns (uint256) {
    return minTimeBetweenClaims;
}

function getCurrentClaimTime() internal view returns (uint256) {
    if (claims.length == 0) {
        return 0;
    } else {
        Claim storage c = claims[claims.length - 1];
        return block.timestamp - c.claimTime;
    }
}
}

