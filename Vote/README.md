Advanced Voting Smart Contract
This smart contract provides a secure and efficient way to conduct a vote with multiple proposals. The contract owner can add proposals to the vote, voters can cast their vote for a specific proposal, and the contract owner can end the vote and determine the winning proposal.

Getting Started
Prerequisites
You will need to have a Solidity compiler installed in order to use this smart contract.

Usage
To use this smart contract, you can simply deploy it to the Ethereum network and interact with it using a web3-enabled wallet or other Ethereum-compatible application.

Adding a Proposal
The contract owner can add a proposal to the vote by calling the addProposal function and providing a name for the proposal.

Casting a Vote
Voters can cast a vote for a specific proposal by calling the vote function and providing the ID of the proposal they wish to vote for.

Ending the Vote
The contract owner can end the vote and determine the winning proposal by calling the endVote function. Once the vote has ended, an event will be emitted that contains the name of the winning proposal.

Optimization
This smart contract has been optimized to minimize gas usage and ensure maximum efficiency.

Security
This smart contract has been designed with security in mind and includes various features to prevent vulnerabilities and attacks. For example, the onlyOwner modifier ensures that only the contract owner can add proposals and end the vote, while the require statements ensure that voters cannot cast more than one vote and that invalid proposal IDs cannot be used.

Built With
Solidity
Ethereum

Authors
Christos Skatharoudis

License
This project is licensed under the MIT License.