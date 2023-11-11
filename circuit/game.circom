pragma circom 2.0.0;

// function generateBoard(n) {
//     var board[8][8];

//     for (var i = 0; i < n; i++) {
//         for (var j = 0; j < n; j++) {
//             board[i][j] = 0;
//         }
//     }

//     return board;
// }

template Game(){
    signal input n;
    signal input queens[8][2]; // 0-row, 1-col
    signal output result; // 0-row, 1-col

    var board[8][8];

    // initializing the board
    // for (var i = 0; i < 8; i++) {
    //     for (var j = 0; j < 8; j++) {
    //         board[i][j] = 0;
    //     }
    // }

    // placing the queens
    var occupied = 1;
    // for (var i = 0; i < n; i++) {
    //     if(occupied == 0) {
    //         var canPlaceQueen;
    //         canPlaceQueen = isOccupied(n, board, queens[i][0], queens[i][1]);
    //         if(canPlaceQueen > 0) {
    //             board[queens[i][0]][queens[i][1]] = 1;
    //         } else {
    //             occupied = 1;
    //         }
    //     }
    // }

    result <-- occupied;
    // for (var i = 0; i < n; i++) {
    //     var canPlaceQueen;
    //     canPlaceQueen = isOccupied(n, board, queens[i][0], queens[i][1]);
    //     if(canPlaceQueen) {
    //         board[queens[i][0]][queens[i][1]] <== 1;
    //     } else {
    //         return 0;
    //     }
    // }
}

function isOccupied(n, board, row, col) {
    var occupied = 1;
    var accum;
    accum = 0;

    // Check row and column
    for (var i = 0; i < n; i++) {
        // accum <== accum + (board[row][i] === 1) + (board[i][col] === 1);
    }

    // Check diagonals
    // for (var i = -n; i < n; i++) {
    //     if (row + i >= 0 && row + i < n && col + i >= 0 && col + i < n) {
    //         accum <== accum + (board[row + i][col + i] === 1);
    //     }
    //     if (row + i >= 0 && row + i < n && col - i >= 0 && col - i < n) {
    //         accum <== accum + (board[row + i][col - i] === 1);
    //     }
    // }

    // occupied <== accum > 0;

    return occupied;
}

component main = Game();

// function isOccupied(n, board, row, col) {
//     var foundInRow;
//     var foundInCol;

//     foundInRow <== 0;
//     foundInCol <== 0;

//     for (var i = 0; i < n; i++) {
//         foundInRow <== foundInRow + board[row][i];
//         foundInCol <== foundInCol + board[i][col];
//     }

//     var hasOne;
//     hasOne <== (foundInRow > 0) || (foundInCol > 0);

//     return hasOne;
// }