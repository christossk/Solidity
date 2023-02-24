// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract InsurancePolicy {
    address payable public policyholder;
    uint256 public policyExpiration;
    uint256 public policyPremium;
    uint256 public policyPayout;
    uint256 public cancellationFee;
    uint256 public gracePeriod;

    constructor(
        uint256 _policyExpiration,
        uint256 _policyPremium,
        uint256 _policyPayout,
        uint256 _cancellationFee,
        uint256 _gracePeriod
    ) {
        policyholder = payable(msg.sender);
        policyExpiration = _policyExpiration;
        policyPremium = _policyPremium;
        policyPayout = _policyPayout;
        cancellationFee = _cancellationFee;
        gracePeriod = _gracePeriod;
    }

    function purchase() internal {
        require(msg.value == policyPremium, "Incorrect payment amount.");
        require(block.timestamp < policyExpiration, "Policy has expired.");
    }

    function extendPolicy(uint256 _policyExpiration) external virtual {
        require(msg.sender == policyholder, "Only policyholder can extend policy.");
        require(_policyExpiration > policyExpiration, "New policy expiration must be later than current.");
        policyExpiration = _policyExpiration;
    }

    function cancel() internal {
        require(msg.sender == policyholder, "Only policyholder can cancel policy.");
        require(block.timestamp < policyExpiration, "Policy has expired.");
        require(block.timestamp >= policyExpiration - gracePeriod, "Cannot cancel policy during grace period.");
        uint256 refundAmount = policyPremium - cancellationFee;
        payable(policyholder).transfer(refundAmount);
        selfdestruct(policyholder);
}

function getPolicyDetails() internal view returns (address, uint256, uint256, uint256, uint256, bool, uint256) {
    bool isPolicyActive = block.timestamp < policyExpiration;
    return (policyholder, policyExpiration, policyPremium, policyPayout, cancellationFee, isPolicyActive, gracePeriod);
}
}