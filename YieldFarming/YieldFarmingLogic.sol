// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./YieldFarmingStorage.sol";

contract YieldFarmingLogic is YieldFarmingStorage {
    using SafeMath for uint256;

    function _stake(address _user, uint256 _amount) internal {
        require(_amount > 0, "Cannot stake 0 tokens");

        token.transferFrom(_user, address(this), _amount);

        Stake storage userStake = stakes[_user];
        userStake.amount = userStake.amount.add(_amount);
        userStake.rewardDebt = userStake.amount.mul(rewardPerBlock).div(1e18);
        userStake.lastBlock = block.number;
    }

    function _unstake(address _user, uint256 _amount) internal {
        Stake storage userStake = stakes[_user];
        require(userStake.amount = _amount, "Insufficient staked tokens");
        userStake.amount = userStake.amount.sub(_amount);
        userStake.rewardDebt = userStake.amount.mul(rewardPerBlock).div(1e18);
        userStake.lastBlock = block.number;
        token.transfer(_user, _amount);
}

function _claim(address _user) internal {
    Stake storage userStake = stakes[_user];

    uint256 rewards = _calculateRewards(_user);

    userStake.rewardDebt = userStake.amount.mul(rewardPerBlock).div(1e18);
    userStake.lastBlock = block.number;

    rewardToken.transfer(_user, rewards);
}

function _calculateRewards(address _user) internal view returns (uint256) {
    Stake storage userStake = stakes[_user];

    if (block.number < endBlock) {
        return 0;
    }

    uint256 blocksSinceLastClaim = block.number.sub(userStake.lastBlock);
    uint256 owedRewards = userStake.amount.mul(rewardPerBlock).mul(blocksSinceLastClaim).div(1e18);

    if (owedRewards > totalRewards) {
        owedRewards = totalRewards;
    }

    uint256 rewards = owedRewards.sub(userStake.rewardDebt);

    return rewards;
}

function _withdrawRewards() internal {
    rewardToken.transfer(owner(), rewardToken.balanceOf(address(this)));
}}