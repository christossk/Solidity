// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanNumerals {
    // Define an array to store the Roman numeral symbols and their corresponding values
    uint[] private arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    string[] private romanSymbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

    // Define the function to convert an integer to its Roman numeral representation
    function toRoman(uint number) public view returns (string memory) {
        require(number >= 1 && number <= 9999, "Number must be between 1 and 9999");

        // Initialize an empty string to store the Roman numeral representation
        string memory roman = "";

        // Loop through the Roman numeral symbols and their corresponding values
        for (uint i = 0; i < arabicValues.length; i++) {
            // If the number is greater than or equal to the current value, append the corresponding symbol(s) to the Roman numeral string
            while (number >= arabicValues[i]) {
                roman = string(abi.encodePacked(roman, romanSymbols[i]));
                number -= arabicValues[i];
            }
        }

        // Return the Roman numeral representation
        return roman;
    }
}
