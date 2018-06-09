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

    function _increaseReputation(uint _id, uint _amount) internal
    {
        Celebrity storage celebrity = celebrities[_id];

        uint oldReputation   = celebrity.reputation;
        uint newReputation   = _boundedAdd(oldReputation, _amount);
        celebrity.reputation = newReputation;

        emit ReputationChanged(_id, oldReputation, newReputation);
    }

    function _decreaseReputation(uint _id, uint _amount) internal
    {
        Celebrity storage celebrity = celebrities[_id];

        uint oldReputation   = celebrity.reputation;
        uint newReputation   = _boundedSub(oldReputation, _amount);
        celebrity.reputation = newReputation;

        emit ReputationChanged(_id, oldReputation, newReputation);
    }

    function _increasePower(uint _id, uint _amount) internal
    {
        Celebrity storage celebrity = celebrities[_id];

        uint oldPower   = celebrity.power;
        uint newPower   = _boundedAdd(oldPower, _amount);
        celebrity.power = newPower;

        emit PowerChanged(_id, oldPower, newPower);
    }

    function _decreasePower(uint _id, uint _amount) internal
    {
        Celebrity storage celebrity = celebrities[_id];

        uint oldPower   = celebrity.power;
        uint newPower   = _boundedSub(oldPower, _amount);
        celebrity.power = newPower;

        emit PowerChanged(_id, oldPower, newPower);
    }

    function _boundedAdd(uint _a, uint _b) internal pure returns (uint)
    {
        uint b_max = UINT_MAX - _a;
        if(_b <= b_max)
        {
            return _a + _b;
        }
        else
        {
            return UINT_MAX;
        }
    }

    function _boundedSub(uint _a, uint _b) internal pure returns (uint)
    {
        uint b_max = _a - UINT_MIN;
        if(_b <= b_max)
        {
            return _a - _b;
        }
        else
        {
            return UINT_MIN;
        }
    }
}