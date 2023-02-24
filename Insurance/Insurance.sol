// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./InsurancePolicy.sol";
import "./InsuranceClaims.sol";
import "./InsurancePayouts.sol";

contract Insurance is InsurancePolicy, InsuranceClaims, InsurancePayouts {
    constructor(
        uint256 _policyExpiration,
        uint256 _policyPremium,
        uint256 _policyPayout,
        uint256 _cancellationFee,
        uint256 _gracePeriod,
        uint256 _minTimeBetweenClaims
    )
        InsurancePolicy(
            _policyExpiration,
            _policyPremium,
            _policyPayout,
            _cancellationFee,
            _gracePeriod
        )
        InsuranceClaims(_minTimeBetweenClaims)
    {}

    function purchase() external payable {
        InsurancePolicy.purchase();
    }

    function extendPolicy(uint256 _policyExpiration) external override {
        InsurancePolicy.extendPolicy(_policyExpiration);
    }

    function cancel() external {
        InsurancePayouts.cancel();
    }

    function claim() external {
        InsuranceClaims.claim();
    }

    function getPolicyDetails() external view returns (address, uint256, uint256, uint256, uint256, bool, uint256) {
        return InsurancePolicy.getPolicyDetails();
    }

    function getClaimDetails(uint256 _claimNumber) external view returns (bool, uint256) {
        return InsuranceClaims.getClaimDetails(_claimNumber);
    }

    function getNumberOfClaims() external view returns (uint256) {
        return InsuranceClaims.getNumberOfClaims();
    }

    function getClaimAmount(uint256 _claimNumber) external view returns (uint256) {
        return InsuranceClaims.getClaimAmount(_claimNumber);
    }

    function getClaimTime(uint256 _claimNumber) external view returns (uint256) {
        return InsuranceClaims.getClaimTime(_claimNumber);
    }

    function setMinTimeBetweenClaims(uint256 _minTimeBetweenClaims) external {
        InsuranceClaims.setMinTimeBetweenClaims(_minTimeBetweenClaims);
    }

    function getMinTimeBetweenClaims() external view returns (uint256) {
        return InsuranceClaims.getMinTimeBetweenClaims();
    }
}
