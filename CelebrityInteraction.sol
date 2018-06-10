pragma solidity ^0.4.24;

import "./CelebrityStatus.sol";

contract CelebrityInteraction is CelebrityStatus
{
    event beatingOccurred(uint injurerId, uint victimId);
    
     function beatWithBat(uint _injurerId, uint _victimId) public 
        isBossOf(msg.sender, _injurerId) 
        isReady(_injurerId)
     {
         Celebrity storage injurer = celebrities[_injurerId];
         Celebrity storage victim  = celebrities[_victimId];
         
         _decreaseReputation(injurer, injurer.reputation / 2);
         _increaseCooldownTime(injurer, 1 minutes);
         _increaseCooldownTime(victim, 3 minutes);
         
         emit beatingOccurred(_injurerId, _victimId);
     }
}