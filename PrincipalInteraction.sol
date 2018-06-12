pragma solidity ^0.4.24;

import "./PrincipalStatus.sol";

contract PrincipalInteraction is PrincipalStatus
{
    //Nonce for rand in discredit
    uint randNonce = 0; 
    event beatingOccurred(uint injurerId, uint victimId);
    
    function beatWithBat(uint _injurerId, uint _victimId) public 
        isBossOf(msg.sender, _injurerId) 
        isReady(_injurerId)
    {
        Principal storage injurer = principals[_injurerId];
        Principal storage victim  = principals[_victimId];
         
        _decreaseReputation(injurer, injurer.reputation / 2);
        _increaseCooldownTime(injurer, 1 minutes);
        _increaseCooldownTime(victim, 3 minutes);
         
        emit beatingOccurred(_injurerId, _victimId);
    }
     
    function collectGarbage(uint _collectorId) public
        isBossOf(msg.sender, _collectorId)
        isReady(_collectorId)
    {
        Principal storage collector = principals[_collectorId];
        
        _increaseReputation(collector, 10);
        _increaseCooldownTime(collector, 30 seconds);
    }
    function discredit(uint _injurerId, uint _victimId) public
        isBossOf(msg.sender, _injurerId)
        isReady(_injurerId)
    {
        Principal storage injurer = principals[_injurerId];
        Principal storage victim  = principals[_victimId];
        
        uint successDiscreditProbability = 
                100 * (injurer.reputation / (injurer.reputation + victim.reputation));
        uint rand = randMod(100);
        
        if (rand <= successDiscreditProbability) {
            _decreaseReputation(victim, victim.reputation / 2);
            _increaseCooldownTime(injurer, 1 minutes);
        } else {
            _decreaseReputation(injurer, injurer.reputation / 2);
            _increaseCooldownTime(injurer, 3 minutes);
        }
    }
    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
    }
}