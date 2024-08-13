// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract Voting {

    // initialize an empty array to hold vote options
    string[] public options;
    // A record of casted votes, this will hold an option and its count.
    mapping (string => uint) private votes;
    // A record of addresses/accounts that has voted
    mapping (address => bool) private hasVoted;

    event Vote(address indexed _user, string _option);

    // constructor function to initialize the voting options
    constructor(string[] memory _options) {
        options = _options;
    }

    /**
     * This function casts a vote in available options
     * it first check to ensure that user has not casted a vote before
     * loops through available options to ensure user choice exists
     * require vote to be avalid option
     * add vote count
     * mark user as voted
    */

    function vote(string memory _option) public {
        // Check if the sender has already voted
        require(!hasVoted[msg.sender], "You have already voted.");

        // Variable to track if the provided option is valid
        bool validOption = false;

        // Loop through the available options to check if the provided option exists
        for (uint i = 0; i < options.length; i++) {
            // Compare the provided option with the current option in the list using keccak256 hash
            // keccak256 is used to ensure the comparison is done on the hashed value, avoiding issues with string comparison
            if (keccak256(abi.encodePacked(options[i])) == keccak256(abi.encodePacked(_option))) {
                validOption = true; // If a match is found, set validOption to true
                break; // Exit the loop early since we found a valid option
            }
        }

        // Ensure that the provided option is valid
        require(validOption, "Invalid voting option.");

        // Increment the vote count for the chosen option
        votes[_option] += 1;

        // Mark the sender's address as having voted to prevent multiple votes
        hasVoted[msg.sender] = true;

        emit Votes(msg.sender, _option);
    }

    /** 
     * This function gets the available votes for a given option
     * It takes ion a parameter of option that matches to the votes map memory
    */
    function getVotes(string memory _option) public view returns (uint) {
        return votes[_option];
    }

    /**
     * This function checks if a given user has casted a vote
     * It takes in a parameter of user with type address and matches it to the hasVoted map memory 
    */
    function checkIfUserVoted(address _user) public view returns (bool) {
        return hasVoted[_user];
    }



}