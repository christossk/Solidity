Roman Numeral Converter
This is a Solidity smart contract that takes a positive integer between 1 and 9999 (both included) as its parameter and returns a string containing the Roman Numeral representation of that integer.

Prerequisites
Solidity compiler
Getting started
Clone the repository

git clone https://github.com/christossk/Solidity/Roman Numerals
Compile the smart contract

solc --bin RomanNumerals.sol -o ./bin
Deploy the smart contract to a blockchain of your choice

Interact with the smart contract using a web3 provider or a client like geth

Usage
Call the convertToRomanNumeral function with a positive integer between 1 and 9999 (both included) as its parameter.
The function will return a string containing the Roman Numeral representation of the integer.
Examples
convertToRomanNumeral(1) returns "I"
convertToRomanNumeral(9) returns "IX"
convertToRomanNumeral(1990) returns "MCMXC"
convertToRomanNumeral(4999) returns "MMMMCMXCIX"

Notes
The smart contract only accepts positive integers between 1 and 9999 (both included).
The Roman Numeral representation of the integer will be returned as a string.
