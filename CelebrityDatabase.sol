pragma solidity ^0.4.24;

import "./ThirdParty/Ownable.sol";
import "./ThirdParty/ERC721/ERC721Token.sol";

/*
    Database recording attributes of celebrities. Supports basic data 
    manipulating functions.
*/
contract CelebrityDatabase is Ownable, ERC721Token
{
    struct Celebrity
    {
        string name;
        uint   dna;
        uint   reputation;
        uint   power;
    }

    enum EDnaFragment
    {
        ELEMENTAL,
        GENDER,
        HEIGHT,
        FACE,
        HAIR_COLOR,
        EYE_COLOR
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

    function getDnaFragment(uint _dna, EDnaFragment _type) public pure returns (uint8)
    {
        uint shiftedDna = _dna / (2 ** (uint(_type) * 8));
        return uint8(shiftedDna & 0xFF);
    }

    function getInjectedDna(uint _dna, uint8 _dnaFragment, EDnaFragment _type) public pure returns (uint _injectedDna)
    {
        uint multiplier = 2 ** (uint(_type) * 8);
        uint clearedDna = _dna & ~(0xFF * multiplier);
        _injectedDna = clearedDna | (_dnaFragment * multiplier);
    }

    function generateRandomDna(string _string) internal pure returns (uint)
    {
        uint rand = uint(keccak256(_string));
        return rand;
    }
}