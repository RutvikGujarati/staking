// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract RewardToke is ERC20{

    constructor(uint256 init) ERC20("RewardToken","RT"){
        _mint(msg.sender,init);
    }

    
}