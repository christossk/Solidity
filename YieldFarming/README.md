Yield Farming Smart Contract
This is a smart contract implementation of a Yield Farming protocol using the Solidity programming language. The contract allows users to stake a specified ERC20 token and earn rewards in another ERC20 token. The amount of rewards distributed per block is configurable, as is the total amount of rewards that will be distributed over the course of the farming period.

The smart contract is split into multiple files to make it more modular and easier to maintain:

YieldFarming.sol: main contract file that implements the public functions for staking, unstaking, claiming rewards, and withdrawing remaining rewards.
YieldFarmingStorage.sol: contract file that defines the storage variables and the Stake struct used to keep track of each user's stake information.
YieldFarmingLogic.sol: contract file that implements the internal functions for staking, unstaking, claiming rewards, and calculating rewards owed to users.
YieldFarmingView.sol: contract file that defines the view functions for users to see the current state of the contract, such as the total amount of tokens staked and the total amount of rewards available.
Usage
Deploy the YieldFarming contract, passing in the addresses of the ERC20 tokens to be used for staking and rewards, as well as the total amount of rewards to be distributed and the reward rate per block.

Users can then stake tokens by calling the stake function and passing in the amount of tokens to be staked.

Users can also unstake tokens by calling the unstake function and passing in the amount of tokens to be unstaked.

Users can claim rewards by calling the claim function.

Users can view the amount of rewards owed to them by calling the calculateRewards function with their address as an argument.

The owner of the contract can withdraw any remaining rewards by calling the withdrawRewards function.

Users can view the current state of the contract by calling the various view functions, such as viewTotalStaked, viewTotalRewards, viewStakeAmount, viewRewardDebt, and viewLastBlock.

License
This smart contract is released under the MIT License.