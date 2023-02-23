# Solidity
Solidity | Smart Contracts

------------

Wallet.sol

In this smart contract, we have a mapping called _balances which tracks the balance of each user's wallet. We also have three functions:

deposit: Allows users to deposit ETH into their wallet.

withdraw: Allows users to withdraw ETH from their wallet.

transfer: Allows users to transfer ETH from their wallet to another user's wallet.

The deposit function requires that the value being deposited is greater than 0, and then adds the value to the _balances mapping for the sender's address.

The withdraw function requires that the amount being withdrawn is greater than 0 and that the sender has sufficient balance to withdraw the specified amount. If these requirements are met, the _balances mapping for the sender's address is updated to reflect the withdrawal, and the specified amount is transferred to the sender's address.

The transfer function requires that the amount being transferred is greater than 0, the recipient's address is valid, and the sender has sufficient balance to transfer the specified amount. If these requirements are met, the _balances mapping for both the sender and recipient addresses are updated to reflect the transfer, and an event is emitted to signify the transfer.

Finally, we have a balanceOf function that allows users to check their wallet balance.

This contract is optimized to save gas by using the payable modifier on the deposit and withdraw functions to enable them to receive and send ETH. We also used the view modifier on the balanceOf function to indicate that it doesn't modify the state of the contract and can be called for free.

------------
