pragma solidity ^0.4.24;

import "./PrincipalHighLevelAction.sol";

contract PrincipalWorld is PrincipalHighLevelAction
{
    uint constant PRINCIPAL_PRICE = 0.0001 ether;

    function buyRandomPrincipal(string _name) external payable
    {
        require(msg.value == PRINCIPAL_PRICE);

        _createPrincipal(_name, generateRandomDna(_name));
    }

    function buyPresetPrincipal(string _name, uint8 _presetId) external payable
    {
        require(msg.value == PRINCIPAL_PRICE);

        uint dna = generateRandomDna(_name);
        dna = getInjectedDna(dna, _presetId, EDnaFragment.FACE);
        _createPrincipal(_name, dna);
    }
}