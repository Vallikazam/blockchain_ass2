// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AIModelMarketplace {
    struct Model {
        string name;
        string description;
        uint256 price;
        address creator;
        uint8 rating;
        uint256 ratingCount;
    }

    mapping(uint256 => Model) public models;
    uint256 public modelCount;
    address public owner;
    mapping(address => uint256) public balances;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        modelCount = 0;
    }

    function listModel(string memory name, string memory description, uint256 price) public {
        modelCount++;
        models[modelCount] = Model(name, description, price, msg.sender, 0, 0);
    }

    function purchaseModel(uint256 modelId) public payable {
        Model storage model = models[modelId];
        require(msg.value == model.price, "Incorrect payment amount");

        payable(model.creator).transfer(msg.value);
    }

    function rateModel(uint256 modelId, uint8 rating) public {
        require(rating >= 1 && rating <= 5, "Rating must be between 1 and 5");

        Model storage model = models[modelId];
        model.rating = (uint8((model.rating * model.ratingCount + rating) / (model.ratingCount + 1)));
        model.ratingCount++;
    }

    function withdrawFunds() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner).transfer(balance);
    }

    function getModelDetails(uint256 modelId) public view returns (string memory, string memory, uint256, address, uint8) {
        Model storage model = models[modelId];
        return (model.name, model.description, model.price, model.creator, model.rating);
    }
}
