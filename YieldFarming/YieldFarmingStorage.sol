// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract YieldFarmingStorage {
    IERC20 public token;
    IERC20 public rewardToken;
    uint256 public totalRewards;
    uint256 public startBlock;
    uint256 public endBlock;
    uint256 public rewardPerBlock;

    constructor(
        IERC20 _token,
        IERC20 _rewardToken,
        uint256 _totalRewards,
        uint256 _startBlock,
        uint256 _endBlock,
        uint256 _rewardPerBlock
    ) {
        token = _token;
        rewardToken = _rewardToken;
        totalRewards = _totalRewards;
        startBlock = _startBlock;
        endBlock = _endBlock;
        rewardPerBlock = _rewardPerBlock;
    }

    struct Stake {
        uint256 amount;
        uint256 rewardDebt;
        uint256 lastBlock;
    }

    mapping(address => Stake) public stakes;
}
