// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 totalHangLooses;

    uint256 private seed;

    enum WaveType { WAVE, HANGLOOSE }
    struct Wave {
        WaveType _type;
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    event NewWave(WaveType _type, address indexed from, uint256 timestamp, string message);

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(WaveType _type, string memory _message) public {
        waves.push(Wave(_type, msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        if (_type == WaveType.WAVE) {
            totalWaves += 1;
            console.log("%s has waved!", msg.sender);
        } else if (_type == WaveType.HANGLOOSE) {
            totalHangLooses += 1;
            console.log("%s has saluted with a shaka!", msg.sender);
        }

        emit NewWave(_type, msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.001 ether;
        if (seed <= 20) {
            require(prizeAmount <= address(this).balance,"Trying to withdraw more money than the contract has.");
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
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