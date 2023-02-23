// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TicTacToeChecker {
    // Board size
    uint8 constant BOARD_SIZE = 3;

    // Board array
    uint8[BOARD_SIZE][BOARD_SIZE] board;

    // Constructor function that initializes the board to all zeros
    constructor() {
        for (uint8 i = 0; i < BOARD_SIZE; i++) {
            for (uint8 j = 0; j < BOARD_SIZE; j++) {
                board[i][j] = 0;
            }
        }
    }

    // Function to get the current state of the board
    function getBoard() public view returns (uint8[BOARD_SIZE][BOARD_SIZE] memory) {
        return board;
    }

    // Function to make a move on the board
    function makeMove(uint8 row, uint8 col, uint8 player) public {
        // Check if the move is within the bounds of the board
        require(row >= 0 && row < BOARD_SIZE, "Row out of bounds");
        require(col >= 0 && col < BOARD_SIZE, "Column out of bounds");

        // Check if the player is valid
        require(player == 1 || player == 2, "Invalid player");

        // Check if the position is already occupied
        require(board[row][col] == 0, "Position already occupied");

        // Make the move
        board[row][col] = player;
    }

    // Function to check if a player has won
    function hasWon(uint8 player) public view returns (bool) {
        // Check rows
        for (uint8 i = 0; i < BOARD_SIZE; i++) {
            bool rowWin = true;
            for (uint8 j = 0; j < BOARD_SIZE; j++) {
                if (board[i][j] != player) {
                    rowWin = false;
                    break;
                }
            }
            if (rowWin) {
                return true;
            }
        }

        // Check columns
        for (uint8 j = 0; j < BOARD_SIZE; j++) {
            bool colWin = true;
            for (uint8 i = 0; i < BOARD_SIZE; i++) {
                if (board[i][j] != player) {
                    colWin = false;
                    break;
                }
            }
            if (colWin) {
                return true;
            }
        }

        // Check diagonal 1
        bool diag1Win = true;
        for (uint8 i = 0; i < BOARD_SIZE; i++) {
            if (board[i][i] != player) {
                diag1Win = false;
                break;
            }
        }
        if (diag1Win) {
            return true;
        }

        // Check diagonal 2
        bool diag2Win = true;
        for (uint8 i = 0; i < BOARD_SIZE; i++) {
            if (board[i][BOARD_SIZE - 1 - i] != player) {
                diag2Win = false;
                break;
            }
        }
        if (diag2Win) {
            return true;
        }

        // No win found
        return false;
    }

    // Function to check if the game is a tie
    function isTie() public view returns (bool) {
        for (uint8 i = 0; i < BOARD_SIZE; i++) {
            for (uint8 j = 0; j < BOARD_SIZE; j++) {
                if (board[i][j] == 0) {
                    return false;
                }
