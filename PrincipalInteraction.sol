pragma solidity ^0.4.24;

import "./PrincipalStatus.sol";

contract PrincipalInteraction is PrincipalStatus
{
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
}