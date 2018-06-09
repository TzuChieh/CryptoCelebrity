pragma solidity ^0.4.24;

import "./CelebrityDatabase.sol";

contract CelebrityStatus is CelebrityDatabase
{
    uint256 constant UINT256_MIN = 0;
    uint256 constant UINT256_MAX = ~uint256(0);
    uint    constant UINT_MIN    = UINT256_MIN;
    uint    constant UINT_MAX    = UINT256_MAX;

    event ReputationChanged(uint id, uint from, uint to);
    event PowerChanged(uint id, uint from, uint to);

    function _increaseReputation(uint id, uint amount) internal
    {
        Celebrity storage celebrity = celebrities[id];

        uint oldReputation   = celebrity.reputation;
        uint newReputation   = _boundedAdd(oldReputation, amount);
        celebrity.reputation = newReputation;

        emit ReputationChanged(id, oldReputation, newReputation);
    }

    function _decreaseReputation(uint id, uint amount) internal
    {
        Celebrity storage celebrity = celebrities[id];

        uint oldReputation   = celebrity.reputation;
        uint newReputation   = _boundedSub(oldReputation, amount);
        celebrity.reputation = newReputation;

        emit ReputationChanged(id, oldReputation, newReputation);
    }

    function _increasePower(uint id, uint amount) internal
    {
        Celebrity storage celebrity = celebrities[id];

        uint oldPower   = celebrity.power;
        uint newPower   = _boundedAdd(oldPower, amount);
        celebrity.power = newPower;

        emit PowerChanged(id, oldPower, newPower);
    }

    function _decreasePower(uint id, uint amount) internal
    {
        Celebrity storage celebrity = celebrities[id];

        uint oldPower   = celebrity.power;
        uint newPower   = _boundedSub(oldPower, amount);
        celebrity.power = newPower;

        emit PowerChanged(id, oldPower, newPower);
    }

    function _boundedAdd(uint a, uint b) internal pure returns (uint)
    {
        uint b_max = UINT_MAX - a;
        if(b <= b_max)
        {
            return a + b;
        }
        else
        {
            return UINT_MAX;
        }
    }

    function _boundedSub(uint a, uint b) internal pure returns (uint)
    {
        uint b_max = a - UINT_MIN;
        if(b <= b_max)
        {
            return a - b;
        }
        else
        {
            return UINT_MIN;
        }
    }
}