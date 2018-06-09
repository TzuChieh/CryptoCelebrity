pragma solidity ^0.4.24;

import "./CelebrityHighLevelAction.sol";

contract CelebrityWorld is CelebrityHighLevelAction
{
    uint constant CELEBRITY_PRICE = 0.0001 ether;

    function buy(string _name) external payable
    {
        require(msg.value == CELEBRITY_PRICE);

        uint id = _createCelebrity(_name, _generateRandomDna(_name));
        celebrityToBoss[id] = msg.sender;
        bossCelebrityCount[msg.sender]++;
    }
}