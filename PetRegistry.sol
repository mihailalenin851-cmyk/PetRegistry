// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
contract PetRegistry {
    address public owner;
    mapping(address => Pet) public pets;
    mapping(address => bool) public registered;

    struct Pet {
        uint age;
        bool isVaccinated;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "you are not a owner");
        _;
    }

    constructor (){
        owner = msg.sender;
    }
    
    function registerPet(uint _age, bool _isVaccinated) public {
        require(!registered[msg.sender], "you already have a pets");
        pets[msg.sender] = Pet(_age, _isVaccinated);
        registered[msg.sender] = true;
    }
    function getPet() public view returns (Pet memory){
    return pets[msg.sender];
    }
    function updateVaccinated (bool _newStatus) public {
        pets[msg.sender].isVaccinated = _newStatus;

    }
    function deletePet (address _user) public onlyOwner{
        require(registered[_user], "This user has no pet");
        delete pets[_user];

    }
    }