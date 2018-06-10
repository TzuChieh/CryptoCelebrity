pragma solidity ^0.4.24;

import "./PrincipalDatabase.sol";

contract PrincipalStatus is PrincipalDatabase
{
    uint256 constant UINT256_MIN = 0;
    uint256 constant UINT256_MAX = ~uint256(0);
    uint    constant UINT_MIN    = UINT256_MIN;
    uint    constant UINT_MAX    = UINT256_MAX;

    event ReputationChanged(uint id, uint from, uint to);
    event PowerChanged(uint id, uint from, uint to);
    
    modifier isBossOf(address _boss, uint _id)
    {
        require(ownerOf(_id) == _boss);
        _;
    }
    
    modifier hasEnoughPower(uint _id, uint _power)
    {
        require(principals[_id].power >= _power);
        _;
    }
    
    modifier isReady(uint _id)
    {
        require(principals[_id].readyTime <= now);
        _;
    }

    function _increaseReputation(Principal storage _target, uint _amount) internal
    {
        uint oldReputation = _target.reputation;
        uint newReputation = _boundedAdd(oldReputation, _amount);
        _target.reputation = newReputation;

        emit ReputationChanged(_target.id, oldReputation, newReputation);
    }

    function _decreaseReputation(Principal storage _target, uint _amount) internal
    {
        uint oldReputation = _target.reputation;
        uint newReputation = _boundedSub(oldReputation, _amount);
        _target.reputation = newReputation;

        emit ReputationChanged(_target.id, oldReputation, newReputation);
    }

    function _increasePower(Principal storage _target, uint _amount) internal
    {
        uint oldPower = _target.power;
        uint newPower = _boundedAdd(oldPower, _amount);
        _target.power = newPower;

        emit PowerChanged(_target.id, oldPower, newPower);
    }

    function _decreasePower(Principal storage _target, uint _amount) internal
    {
        uint oldPower = _target.power;
        uint newPower = _boundedSub(oldPower, _amount);
        _target.power = newPower;

        emit PowerChanged(_target.id, oldPower, newPower);
    }
    
    function _increaseCooldownTime(Principal storage _target, uint _amount) internal
    {
        _target.readyTime = _boundedAdd(_target.readyTime, _amount);
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