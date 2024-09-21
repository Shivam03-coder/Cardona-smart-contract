// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CampaignsData {
    address[] public depolyedCapmaigns;

    event campaignCreated(
        string title,
        uint256 requiredAmount,
        address indexed owner,
        address campaignAddress,
        string Imageurl,
        string Storyurl,
        uint256 indexed timestamps,
        string indexed categoryOfCampaign
    );

    function CreateCampaign(
        string memory campaignTitle,
        uint256 requiredCampaignAmount,
        string memory ImageUrl,
        string memory cateogory,
        string memory storyUrl
    ) public {
        Campaign newCampaign = new Campaign(
            // CREATE A NEW SMART CONTRACT ON BLOCKCHAIN
            //  WITH A UINQUE ADDRESS EVERY TIME A CAPAIGN CREATED
            campaignTitle,
            requiredCampaignAmount,
            ImageUrl,
            storyUrl
        );

        depolyedCapmaigns.push(address(newCampaign));

        // EMITTING EVENT campaignCreated

        emit campaignCreated(
            campaignTitle,
            requiredCampaignAmount,
            msg.sender,
            address(newCampaign),
            ImageUrl,
            storyUrl,
            block.timestamp,
            cateogory
        );
    }
}

contract Campaign {
    // DEFINING STATE VARIABLES
    string public title;
    uint256 public AmountNeededforFund;
    uint256 public AmountRecivedforFund;
    string public image;
    string public storyofFundCause;
    address payable public Owner;

    // EVENTS

    event donated(
        address indexed donar,
        uint256 indexed amount,
        uint256 indexed timestamps
    );

    constructor(
        string memory _title,
        uint256 _AmountNeededforFund,
        string memory _image,
        string memory _storyofFundCause
    ) {
        title = _title;
        AmountNeededforFund = _AmountNeededforFund;
        image = _image;
        storyofFundCause = _storyofFundCause;
        Owner = payable(msg.sender);
    }

    modifier CheckAmount() {
        require(
            AmountNeededforFund > AmountRecivedforFund,
            "TotalAmount has been collected"
        );
        _;
    }

    function donateAmount() public payable CheckAmount {
        Owner.transfer(msg.value); // transfer money to owner;
        AmountRecivedforFund += msg.value;
        // EVENT TRIGGERED
        emit donated(msg.sender, msg.value, block.timestamp);
    }
}
