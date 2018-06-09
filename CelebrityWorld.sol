pragma solidity ^0.4.24;

import "./CelebrityHighLevelAction.sol";

contract CelebrityWorld is CelebrityHighLevelAction
{
    uint constant CELEBRITY_PRICE = 0.0001 ether;

    function buyRandomCelebrity(string _name) external payable
    {
        require(msg.value == CELEBRITY_PRICE);

        uint id = _createCelebrity(_name, generateRandomDna(_name));
        celebrityToBoss[id] = msg.sender;
        bossCelebrityCount[msg.sender]++;
    }

    function buyPresetCelebrity(string _name, uint8 _presetId) external payable
    {
        require(msg.value == CELEBRITY_PRICE);

        uint dna = generateRandomDna(_name);
        dna = getInjectedDna(dna, _presetId, EDnaFragment.FACE);

        uint id = _createCelebrity(_name, dna);
        celebrityToBoss[id] = msg.sender;
        bossCelebrityCount[msg.sender]++;
    }
}