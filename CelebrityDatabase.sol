pragma solidity ^0.4.24;

/*
    Database recording attributes of celebrities. Supports basic data 
    manipulating functions.
*/
contract CelebrityDatabase
{
    struct Celebrity
    {
        string name;
        uint   dna;
        uint   reputation;
        uint   power;
    }

    event CelebrityCreated(uint id, string name, uint dna);
    
    Celebrity[] public celebrities;

    mapping (uint    => address) public celebrityToBoss;
    mapping (address => uint   ) public bossCelebrityCount;

    function _createCelebrity(string _name, uint _dna) internal
    {
        uint id = celebrities.push(Celebrity(_name, _dna, 0, 0)) - 1;
        celebrityToBoss[id] = msg.sender;
        bossCelebrityCount[msg.sender]++;

        emit CelebrityCreated(id, _name, _dna);
    }
}