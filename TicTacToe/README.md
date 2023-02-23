# Tic-Tac-Toe Checker

------------

Tic-Tac-Toe Checker
This is a Solidity contract that implements a Tic-Tac-Toe game checker. Given a board state, it checks if there is a winner or if the game is a tie.

The contract is fully optimized for gas and security, and includes the following features:

SafeMath library to prevent integer overflow and underflow errors.
Assert library to check pre- and post-conditions and prevent bugs.
Enums to represent the different cell states (empty, X, and O).
Struct to represent the board state.
Function to check if a board is valid (i.e., has exactly 9 cells and valid cell values).
Function to check if a board has a winner (i.e., three cells in a row, column, or diagonal have the same value).
Function to check if a board is a tie (i.e., all cells are filled and there is no winner).
Functions to get and set the board state.
Prerequisites
Solidity compiler (version 0.8.0 or higher)
Remix IDE (or another Solidity development environment)
Usage
To use the Tic-Tac-Toe Checker, follow these steps:

Copy the code from tic-tac-toe-checker.sol and paste it into a new Solidity file in Remix IDE (or another Solidity development environment).
Compile the code using the Solidity compiler.
Deploy the contract to the Ethereum network.
Call the setBoard function to set the board state (as a string of 9 characters, representing the cells in row-major order). Only the owner of the contract can set the board state.
Call the checkWinner function to check if the board has a winner. If there is a winner, the function returns the winning cell values (as a tuple of 3 integers). If there is no winner, the function returns (0, 0, 0).
Call the checkTie function to check if the board is a tie. If the board is a tie, the function returns true. If the board is not a tie, the function returns false.
Call the getBoard function to get the current board state (as a string of 9 characters).
Note that the board state is represented as a string of 9 characters, where each character can be one of the following:

0 (empty cell)
1 (X cell)
2 (O cell)

License
This project is licensed under the MIT License. Feel free to use and modify the code as you see fit.