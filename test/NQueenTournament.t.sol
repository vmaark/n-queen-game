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
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);
    }

    function test_cannotSubmitSolutionTwice() public {
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        uint8 rounds = tournament.queensInRound();
        vm.expectRevert("Already guessed for this round");
        tournament.submitSolution(new bytes[](0), rounds);
    }

    function test_doesntStartNewRoundFor10Minutes() public {
        address player2 = vm.addr(2);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(10 minutes - 1 seconds);

        vm.startPrank(player2);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);
    }

    function test_cannotSubmitSolutionForIncorrectRound() public {
        uint8 rounds = tournament.queensInRound() + 1;
        vm.expectRevert("Incorrect round");
        tournament.submitSolution(new bytes[](0), rounds);
    }

    function test_startsNewRoundAfter10Minutes() public {
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(10 minutes + 1 seconds);

        tournament.submitSolution(new bytes[](0), tournament.queensInRound() + 1);
        assertEq(tournament.queensInRound(), 3);
        assertEq(tournament.tournamentCounter(), 0);
    }

    function test_cannotSubmitInNextRoundIfDidntSolveEarlier() public {
        address player2 = vm.addr(2);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(10 minutes + 1 seconds);

        vm.startPrank(player2);
        uint8 rounds = tournament.queensInRound() + 1;
        vm.expectRevert("Haven't submitted previous round");
        tournament.submitSolution(new bytes[](0), rounds);
        vm.stopPrank();
    }

    function testPreviousTournamentOverAfter20mins() public {
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.warp(20 minutes + 1 seconds);

        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 1);
    }

    function testNextRoundTriggeredAt10thSubmit() public {
        address player2 = vm.addr(2);
        address player3 = vm.addr(3);
        address player4 = vm.addr(4);
        address player5 = vm.addr(5);
        address player6 = vm.addr(6);
        address player7 = vm.addr(7);
        address player8 = vm.addr(8);
        address player9 = vm.addr(9);
        address player10 = vm.addr(10);
        address player11 = vm.addr(11);

        vm.startPrank(player2);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player3);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player4);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player5);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player6);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player7);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player8);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player9);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player10);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 2);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player11);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 3);
        assertEq(tournament.tournamentCounter(), 0);

        vm.startPrank(player11);
        tournament.submitSolution(new bytes[](0), tournament.queensInRound());
        vm.stopPrank();
        assertEq(tournament.queensInRound(), 3);
        assertEq(tournament.tournamentCounter(), 0);
    }
}
