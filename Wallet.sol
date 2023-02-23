pragma solidity ^0.8.0;

contract Wallet {
    // Mapping that tracks the balance of each user's wallet
    mapping (address => uint256) private _balances;

    // Event that is emitted when a transfer occurs
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);

    // Function that allows users to deposit ETH into their wallet
    function deposit() public payable {
        // Ensure that the value being deposited is greater than 0
        require(msg.value > 0, "Cannot deposit 0 value");
        // Add the value to the `_balances` mapping for the sender's address
        _balances[msg.sender] += msg.value;
    }

    // Function that allows users to withdraw ETH from their wallet
    function withdraw(uint256 amount) public {
        // Ensure that the amount being withdrawn is greater than 0
        require(amount > 0, "Cannot withdraw 0 value");
        // Ensure that the sender has sufficient balance to withdraw the specified amount
        require(amount <= _balances[msg.sender], "Insufficient balance");
        // Update the `_balances` mapping for the sender's address to reflect the withdrawal
        _balances[msg.sender] -= amount;
        // Transfer the specified amount to the sender's address
        payable(msg.sender).transfer(amount);
    }

    // Function that allows users to transfer ETH from their wallet to another user's wallet
    function transfer(address recipient, uint256 amount) public {
        // Ensure that the amount being transferred is greater than 0
        require(amount > 0, "Cannot transfer 0 value");
        // Ensure that the recipient's address is valid
        require(recipient != address(0), "Invalid recipient address");
        // Ensure that the sender has sufficient balance to transfer the specified amount
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        // Update the `_balances` mapping for both the sender and recipient addresses to reflect the transfer
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        // Emit an event to signify the transfer
        emit Transfer(msg.sender, recipient, amount);
    }

    // Function that allows users to check their wallet balance
    function balanceOf(address account) public view returns (uint256) {
        // Return the balance of the specified account from the `_balances` mapping
        return _balances[account];
    }
}
