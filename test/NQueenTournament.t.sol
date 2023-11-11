// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {NQueenTournament} from "../src/NQueenTournament.sol";

contract TournamentTest is Test {
    NQueenTournament public tournament;

    function setUp() public {
        tournament = new NQueenTournament();
    }

    function test_canStartTournament() public {
        tournament.submitSolution(new bytes[](0), 0);
        assertEq(tournament.round(), 2);
        assertEq(tournament.tournamentCounter(), 0);
    }

    function test_doesntStartNewRoundFor10Minutes() public {
        address player2 = vm.addr(2);
        tournament.submitSolution(new bytes[](0), 0);
        assertEq(tournament.round(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(10 minutes - 1 seconds);

        vm.startPrank(player2);
        tournament.submitSolution(new bytes[](0), 0);
        vm.stopPrank();
        assertEq(tournament.round(), 2);
        assertEq(tournament.tournamentCounter(), 0);
    }

    function test_startsNewRoundAfter10Minutes() public {
        tournament.submitSolution(new bytes[](0), 0);
        assertEq(tournament.round(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(10 minutes + 1 seconds);

        tournament.submitSolution(new bytes[](0), 0);
        assertEq(tournament.round(), 3);
        assertEq(tournament.tournamentCounter(), 0);
    }

    function test_cannotSubmitInNextRoundIfDidntSolveEarlier() public {
        address player2 = vm.addr(2);
        tournament.submitSolution(new bytes[](0), 0);
        assertEq(tournament.round(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(10 minutes + 1 seconds);

        vm.startPrank(player2);
        vm.expectRevert("Haven't submitted previous round");
        tournament.submitSolution(new bytes[](0), 0);
        vm.stopPrank();
    }

    function testPreviousTournamentOverAfter20mins() public {
        tournament.submitSolution(new bytes[](0), 0);
        assertEq(tournament.round(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(20 minutes + 1 seconds);

        tournament.submitSolution(new bytes[](0), 0);
        assertEq(tournament.round(), 2);
        assertEq(tournament.tournamentCounter(), 1);
    }
}
