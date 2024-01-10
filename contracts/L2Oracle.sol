//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract L2Oracle {
    uint256 public lastUpdatedValue;
    address l1Oracle;
    address l2Bridge;

    event RewardMultiplierUpdated(uint256 newMultiplier);

    constructor(address _l1Oracle, address _l2Bridge) {
        l1Oracle = _l1Oracle;
        l2Bridge = _l2Bridge;
    }

    function updateRewardMultiplier(uint256 _rewardMultiplier) external {
        require(msg.sender == l2Bridge, "Only L2 Bridge can update");
        lastUpdatedValue = _rewardMultiplier;
        emit RewardMultiplierUpdated(_rewardMultiplier);
    }
}