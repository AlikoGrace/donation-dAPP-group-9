

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Donation{
    // public variables
    address public owner;
    address public beneficiary;
    // bool public emergencyPaused;

    // 
    struct Donation {
        address donor;
        uint256 amount;
        string message;
        uint256 timestamp;
    }

    // array to store donations
    Donation[] public donations;
    mapping(address => bool) public donors;

    // event to show donation is received
    event DonationReceived(address indexed donor, uint256 amount, string message);

    // initialize contract with owner
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
    }

    // function to donate MATIC
    function donate(string memory _message) external payable {
        //  add donation amount
        //  enter purpose
        // click to donate
        // increment total donation amount
        //  update donations mapping
        
        require(msg.value > 0, "Donation amount must be greater than 0");
        
        // add donation to donations array
        donations.push(Donation({
            donor: msg.sender,
            amount: msg.value,
            message: _message,
            timestamp: block.timestamp
        }));
        
        if (!donors[msg.sender]) {
            donors[msg.sender] = true;
        }
        
        emit DonationReceived(msg.sender, msg.value, _message);
    
    }

   // a function to enable you withdraw donated funds
    function viewTotalDonations() public{

    }

    function viewDonerList() public{

    }
}