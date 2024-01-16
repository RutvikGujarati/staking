// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import "../lib/openzeppelin-contracts/contracts/utils/math/Math.sol";

contract Staking is ReentrancyGuard{
    using Math for uint256;
    IERC20 public S_stakingToken;
    IERC20 public S_rewardToken;

    uint256 constant RewartRate = 10;
    uint256 private TotalStackedToken;
    uint256 public RewardPerTokenStored;
    uint256 public lastUpdateTime;

    mapping (address => uint)public stakedBalance;
    mapping (address => uint)public Rewards;
    mapping (address => uint) public UserRewardperTokenId;

    event Stacked(address indexed user, uint256 indexed amount);
    event Withdraw(address indexed user, uint256 indexed amount);
    event RewardClaimed(address indexed user, uint256 indexed amount);

    constructor(address stakingToken, address rewardToken){
         S_stakingToken= IERC20(stakingToken);
         S_rewardToken = IERC20(rewardToken);
    }

    function  RewardPerToken() public view returns (uint) {
        if(TotalStackedToken == 0){
            return RewardPerTokenStored;
        }
         uint256 TotalTime = block.timestamp - (lastUpdateTime);
        uint256 TotalRewards = RewartRate * TotalTime;
        return RewardPerTokenStored + (TotalRewards * 1e18 / TotalStackedToken);
        }
        function earned(address account) public view returns (uint) {
            uint256 rewardPerToken = RewardPerToken();
            uint256 userRewardPerTokenId = UserRewardperTokenId[account];
        
            uint256 stakedBalanceResult = stakedBalance[account].mul(RewardPerToken.trySub(userRewardPerTokenId)).tryDiv(1e18);
            uint256 rewardsResult = Rewards[account];
        
            return stakedBalanceResult.add(rewardsResult);
        }
        
}
