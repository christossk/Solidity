// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vote {
    // Struct representing a voter
    struct Voter {
        bool hasVoted; // whether or not the voter has cast a vote
        uint256 votedProposalId; // the ID of the proposal the voter has voted for
    }

    // Struct representing a proposal
    struct Proposal {
        string name; // the name of the proposal
        uint256 voteCount; // the number of votes the proposal has received
    }

    // Address of the contract owner, who is responsible for adding proposals and ending the vote
    address private _owner;

    // Mapping that tracks each voter's voter status (whether or not they have voted)
    mapping (address => Voter) private _voters;

    // Array of proposals
    Proposal[] private _proposals;

    // Event that is emitted when a new proposal is added
    event ProposalAdded(string name);

    // Event that is emitted when the vote is ended and the results are tallied
    event VoteEnded(string winner);

    // Constructor function that sets the contract owner to the address that deployed the contract
    constructor() {
        _owner = msg.sender;
    }

    // Modifier that ensures only the contract owner can call a certain function
    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the contract owner can call this function");
        _;
    }

    // Function that allows the contract owner to add a proposal
    function addProposal(string memory name) public onlyOwner {
        // Create a new proposal and add it to the `_proposals` array
        Proposal memory proposal = Proposal(name, 0);
        _proposals.push(proposal);

        // Emit an event to signify that a new proposal has been added
        emit ProposalAdded(name);
    }

    // Function that allows voters to cast a vote for a specific proposal
    function vote(uint256 proposalId) public {
        // Ensure that the voter has not already cast a vote
        require(!_voters[msg.sender].hasVoted, "You have already cast a vote");

        // Ensure that the proposal ID is valid
        require(proposalId >= 0 && proposalId < _proposals.length, "Invalid proposal ID");

        // Mark the voter as having cast a vote and record the ID of the proposal they voted for
        _voters[msg.sender].hasVoted = true;
        _voters[msg.sender].votedProposalId = proposalId;

        // Increment the vote count for the specified proposal
        _proposals[proposalId].voteCount++;
    }

    // Function that allows the contract owner to end the vote and tally the results
    function endVote() public onlyOwner {
        // Ensure that the vote has not already ended
        require(_proposals.length > 0, "There are no proposals to vote on");

        // Determine the proposal with the most votes
        uint256 winnerId = 0;
        uint256 winnerVoteCount = 0;
        for (uint256 i = 0; i < _proposals.length; i++) {
            if (_proposals[i].voteCount > winnerVoteCount) {
                winnerId = i;
                winnerVoteCount = _proposals[i].voteCount;
            }
        }

        // Emit an event to signify that the vote has ended and the winner has been determined
        emit VoteEnded(_proposals[winnerId].name);
    }
}
