pragma solidity ^0.4.24;

import "./ThirdParty/Ownable.sol";
import "./ThirdParty/ERC721/ERC721Token.sol";

/*
    Database of principals. Supports basic data manipulating functions.
*/
contract PrincipalDatabase is Ownable, ERC721Token
{
    struct Principal
    {
        uint   id;
        string name;
        uint   dna;
        uint   reputation;
        uint   power;
        uint   readyTime;
    }

    /*
        Supported types of DNA fragment. Each DNA fragment has 8 bits and 
        stores information regarding to its representing type. A Celebrity's
        DNA has 256 bits, so in theory 32 kinds of DNA fragment can exist
        at the same time.
    */
    enum EDnaFragment
    {
        ELEMENTAL,
        GENDER,
        HEIGHT,
        FACE,
        HAIR_COLOR,
        EYE_COLOR
    }

    event PrincipalCreated(uint id, string name, uint dna);
    
    Principal[] public principals;
    
    constructor() 
        Ownable()
        ERC721Token("CryptoPrincipal", "CP")
        internal
    {}

    function _createPrincipal(string _name, uint _dna) internal returns (uint _id)
    {
        _id = principals.length;
        _mint(msg.sender, _id);
        principals.push(Principal(_id, _name, _dna, 0, 0, now));

        emit PrincipalCreated(_id, _name, _dna);
    }

    /*
        Given a DNA and the type of the DNA fragment, extracts and returns the 
        DNA fragment.
    */
    function getDnaFragment(uint _dna, EDnaFragment _type) public pure returns (uint8)
    {
        uint shiftedDna = _dna / (2 ** (uint(_type) * 8));
        return uint8(shiftedDna & 0xFF);
    }

    /*
        Injects a 8-bit sized DNA fragment into a given DNA. An enum is also
        needed in order to specify the type of the DNA fragment.
    */
    function getInjectedDna(uint _dna, uint8 _dnaFragment, EDnaFragment _type) public pure returns (uint _injectedDna)
    {
        uint multiplier = 2 ** (uint(_type) * 8);
        uint clearedDna = _dna & ~(0xFF * multiplier);
        _injectedDna = clearedDna | (_dnaFragment * multiplier);
    }

    /* 
        Generates a random DNA given a string. The string served as a seed for
        the random number generator.
     */
    function generateRandomDna(string _string) internal pure returns (uint)
    {
        uint rand = uint(keccak256(abi.encodePacked(_string)));
        return rand;
    }
}