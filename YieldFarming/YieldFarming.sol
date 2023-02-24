// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./YieldFarmingStorage.sol";
import "./YieldFarmingLogic.sol";
import "./YieldFarmingView.sol";

contract YieldFarming is Ownable, YieldFarmingStorage, YieldFarmingLogic, YieldFarmingView {
    constructor(
        IERC20 _token,
        IERC20 _rewardToken,
        uint256 _totalRewards,
        uint256 _startBlock,
        uint256 _endBlock,
        uint256 _rewardPerBlock
    ) YieldFarmingStorage(_token, _rewardToken, _totalRewards, _startBlock, _endBlock, _rewardPerBlock) {}

    function stake(uint256 _amount) external {
        _stake(msg.sender, _amount);
    }

    function unstake(uint256 _amount) external {
        _unstake(msg.sender, _amount);
    }

    function claim() external {
        _claim(msg.sender);
    }

    function calculateRewards(address _user) public view returns (uint256) {
        return _calculateRewards(_user);
    }

    function withdrawRewards() external onlyOwner {
        _withdrawRewards();
    }
}
