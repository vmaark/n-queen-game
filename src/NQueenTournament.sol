// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract NQueenTournament {
    event SolutionSubmitted(
        address indexed solver, uint256 indexed tournamentCounter, uint8 indexed round, bool success
    );

    struct Position {
        uint8 x;
        uint8 y;
    }

    struct UserState {
        bool success;
        uint8 round;
    }

    uint256 public tournamentCounter;
    uint8 public round = 2;

    uint256 public startTimestamp;
    uint8 public numberOfSolvers;
    mapping(uint256 => mapping(address => UserState)) public players;

    function submitSolution(bytes[] memory proof, uint8 _round) public {
        // if the previous game is over, start a new one
        if (startTimestamp + (round - 1) * 10 minutes + 10 minutes < block.timestamp) {
            startTimestamp = block.timestamp;
            round = 2;
            tournamentCounter++;
        }

        // if the previous round is over, start a new one
        if (startTimestamp + (round - 1) * 10 minutes < block.timestamp) {
            round++;
        }

        require(players[tournamentCounter][msg.sender].round != round, "Already guessed for this round");
        require(
            round == 2 || players[tournamentCounter][msg.sender].round == round - 1, "Haven't submitted previous round"
        );
        require(round == 2 || players[tournamentCounter][msg.sender].success, "Failed to solve previous round");

        (bool success) = validateSolution(proof, round);
        players[tournamentCounter][msg.sender] = UserState(success, round);

        emit SolutionSubmitted(msg.sender, tournamentCounter, round, success);

        if (success) {
            numberOfSolvers++;
        }

        if (numberOfSolvers == 10) {
            round++;
            numberOfSolvers = 0;
        }
    }

    function hasFinished() public view returns (bool) {
        return startTimestamp + (round - 1) * 10 minutes < block.timestamp;
    }

    function validateSolution(bytes[] memory proof, uint256 _round) private returns (bool) {
        return true;
    }
}
