// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./YieldFarmingStorage.sol";

contract YieldFarmingView is YieldFarmingStorage {
function viewTotalStaked() public view returns (uint256) {
return token.balanceOf(address(this));
}
function viewTotalRewards() public view returns (uint256) {
    return rewardToken.balanceOf(address(this));
}

function viewStakeAmount(address _user) public view returns (uint256) {
    return stakes[_user].amount;
}

function viewRewardDebt(address _user) public view returns (uint256) {
    return stakes[_user].rewardDebt;
}

function viewLastBlock(address _user) public view returns (uint256) {
    return stakes[_user].lastBlock;
}
}