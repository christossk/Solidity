// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./InsurancePolicy.sol";

contract InsurancePayouts is InsurancePolicy {
function payPolicyholder(uint256 amount) internal {
payable(policyholder).transfer(amount);
}
}

