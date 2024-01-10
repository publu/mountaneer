//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import "./IBridge.sol";

contract L1Oracle {
    address l1Bridge;
    address L2Oracle

    constructor(address _l1Bridge) {
      l1Bridge = _l1Bridge;
    }

    uint256 public lastUpdatedValue;

    function updateRewardMultiplierOnL2(uint256 _rewardMultiplier) public {
        require(_rewardMultiplier != lastUpdatedValue, "Value has not changed");
        lastUpdatedValue = _rewardMultiplier;

        // Encode the function call to the L2 oracle contract
        bytes memory data = abi.encodeWithSignature("updateRewardMultiplier(uint256)", _rewardMultiplier);

        // Send the message to the L2 oracle contract
        sendMessageToL2(L2Oracle, data);
    }

    function sendMessageToL2(address _to, bytes memory _calldata) internal {
        IBridge bridge = IBridge(l1Bridge);
        uint32 destinationNetwork = 1101; // zkEVM
        bool forceUpdateGlobalExitRoot = false; 
        bridge.bridgeMessage{value: msg.value}(
            destinationNetwork,
            _to,
            forceUpdateGlobalExitRoot,
            _calldata
        );
    }
}
