// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Token1, Token2} from "../src/ERC20.sol";
import {MarketPlace} from "../src/MarketPlace.sol";

contract DeploymentScript is Script {
    function run() external {
        uint256 deploy = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deploy);

        //new Token1();
        //new Token2();
        new MarketPlace(
            address(0x5eB7c71f8c388Ef027e35A0ADb30a555f2F9752a),
            address(0xBb79Ce7A1C5C9606eeFdeF4050d7fD67Ac3dB4f0) 
        );
        vm.stopBroadcast();
    }
}
