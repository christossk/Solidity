// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import SafeMath library to prevent integer overflow and underflow errors
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SlotMachine {
    // Use SafeMath for uint256 to prevent integer overflow and underflow errors
    using SafeMath for uint256;
    
    // Contract owner's address and betting amount
    address payable public owner;
    uint256 public bettingAmount;
    
    // Contract balance and player balances
    uint256 public balance;
    mapping(address => uint256) public playerBalance;
    
    // Keep track of players who have already played
    mapping(address => bool) public hasPlayed;
    
    // Events for when a player plays and claims winnings
    event Played(address player, uint256 amount, uint8[] results, bool won);
    event WinningsClaimed(address player, uint256 amount);
    
    // Constructor function that initializes the contract owner and betting amount
    constructor() {
        owner = payable(msg.sender);
        bettingAmount = 0.01 ether; // Set default betting amount to 0.01 ether
        balance = 0;
    }
    
    // Function for playing the slot machine
    function play() public payable {
        // Check if player has sent enough ether to place a bet
        require(msg.value >= bettingAmount, "Insufficient bet amount.");
        
        // Check if player has already played
        require(!hasPlayed[msg.sender], "You have already played.");
        
        // Generate random results using a seed derived from current block data and player address
        uint8[] memory results = new uint8[](3);
        uint256 seed = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender)));
        for (uint8 i = 0; i < 3; i++) {
            results[i] = uint8((seed >> (i * 8)) & 0xff) % 10; // Get random number between 0 and 9
        }
        
        // Calculate winnings based on the results
        uint256 winnings = 0;
        if (results[0] == results[1] && results[1] == results[2]) {
            winnings = bettingAmount.mul(100); // Three of a kind pays 100x the betting amount
        } else if (results[0] == results[1] || results[1] == results[2]) {
            winnings = bettingAmount.mul(10); // Two of a kind pays 10x the betting amount
        } else if (results[0] == results[2]) {
            winnings = bettingAmount.mul(5); // Two of a kind with the third number matching pays 5x the betting amount
        }
        
        // Update player balance and contract balance
        playerBalance[msg.sender] = winnings.add(playerBalance[msg.sender]);
        balance = balance.add(msg.value).sub(winnings);
        hasPlayed[msg.sender] = true;
        
        // Emit event
        emit Played(msg.sender, msg.value, results, winnings > 0); // Pass in whether the player won or not
    }
    
    // Function for players to claim their winnings
    function claimWinnings() public {
        // Check if player has any winnings to claim
        require(playerBalance[msg.sender] > 0, "You have no winnings to claim.");
        
        // Transfer winnings to player
        uint256 amount = playerBalance[msg.sender];
        playerBalance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    
    // Emit event
    emit WinningsClaimed(msg.sender, amount);
}

// Function for the contract owner to withdraw the contract balance
function withdrawBalance() public {
    // Check if caller is the contract owner
    require(msg.sender == owner, "Only the contract owner can withdraw the balance.");
    
    // Transfer balance to owner
    uint256 amount = balance;
    balance = 0;
    owner.transfer(amount);
}

// Function for the contract owner to update the betting amount
function setBettingAmount(uint256 newAmount) public {
    // Check if caller is the contract owner
    require(msg.sender == owner, "Only the contract owner can update the betting amount.");
    
    // Update betting amount
    bettingAmount = newAmount;
}

// Function to get the current contract balance
function getBalance() public view returns (uint256) {
    return balance;
}

// Function to get a player's current balance
function getPlayerBalance() public view returns (uint256) {
    return playerBalance[msg.sender];
}}