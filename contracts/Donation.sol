

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

    uint public totalDonationAmount = 0;

    // event to show donation is received
    event DonationReceived(address indexed donor, uint256 amount, string message);
    // event to allow withdrawal 


    /** 
    SECURITY REQUIREMENT
    * 1. Access Control : 
    * A Modifier to allow administrative functions restricted to the Contract Owner
    * denying donors from modifying contract parameters 
    */
    modifier onlyOwner() {
        require(msg.sender == owner, "Sorry, you are not permitted. Only the Contract Owner");
        _;
    }

    /**
    ADMINISTRATIVE FUNCTION
    * 2. Emergency Stop
    * A mechanism for the contract owner/administrator 
    * to pause or halt all contract operations in case of emergencies or vulnerabilities.
    */
    

    // initialize contract with owner/beneficiary
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
    }


    /**
    * Functional Requirement
    * 1. Donate MATIC
    * Users must be able to send MATIC to the smart contract's address to make a donation.
    * Donations can be of any value in MATIC.
    */
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


    /**
    * Functional Requirement
    * 3. View Total Donations
    */
    // a function to get total donated funds: MATIC
    function viewTotalDonations() external view returns (uint256){
        uint256 total = 0;
        for (uint256 i = 0; i < donations.length; i++) {
            total += donations[i].amount;
        }
        return total;
    }


    /**
    * Functional Requirement
    * 4. View Donor List
    */
    function viewDonerList() external view returns (address[] memory){
        address[] memory donorList = new address[](donations.length);
        for (uint256 i = 0; i < donations.length; i++) {
            donorList[i] = donations[i].donor;
        }
        return donorList;
    }


    /** 
    ADMINISTRATIVE FUNCTION
    1. Set Beneficiary 
    */
    function setBeneficiary(address _newBeneficiary) external onlyOwner {
        beneficiary = _newBeneficiary;
    }
    
    
    /**
    * Functional Requirement
    * 5. Withdraw Funds
    */
    function withdraw() external onlyOwner {
       
    }

   
}