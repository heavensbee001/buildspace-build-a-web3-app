// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address=>uint256) waves;

    uint256 totalHangLooses;
    mapping(address=>uint256) hangLooses;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function wave() public {
        waves[msg.sender] += 1;
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }
    function hangLoose() public {
        hangLooses[msg.sender] += 1;
        totalHangLooses += 1;
        console.log("%s has done the hang loose sign!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getTotalHangLooses() public view returns (uint256) {
        console.log("We have %d total hang looses!", totalHangLooses);
        return totalHangLooses;
    }
}