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

    function _createCelebrity(string _name, uint _dna) internal returns (uint _id)
    {
        _id = celebrities.push(Celebrity(_name, _dna, 0, 0)) - 1;
        celebrityToBoss[_id] = msg.sender;
        bossCelebrityCount[msg.sender]++;

        emit CelebrityCreated(_id, _name, _dna);
    }

    function _generateRandomDna(string _string) internal pure returns (uint)
    {
        uint rand = uint(keccak256(_string));
        return rand;
    }
}