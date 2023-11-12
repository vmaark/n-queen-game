pragma circom 2.0.3;

// function generateBoard(n) {
//     var board[8][8];

//     for (var i = 0; i < n; i++) {
//         for (var j = 0; j < n; j++) {
//             board[i][j] = 0;
//         }
//     }

//     return board;
// }

// {
//   "n": 8,
//   "queens": [0, 0]
// }
// { "n": "8", "queens": [["0", "0"],["7", "7"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"], ["0", "0"]] }

template Game(){
    signal input n;
    signal input queens[8][2]; // 0-row, 1-col
    signal output result;

    var board[8][8];

    // initializing the board
    for (var i = 0; i < 8; i++) {
        for (var j = 0; j < 8; j++) {
            board[i][j] = 0;
        }
    }

    var flag = 0;  // Flag variable
    // placing the queens
    for (var i = 0; i < 8; i++) {
        if(flag == 0) {
            var row = queens[i][0];
            var col = queens[i][1];
            var canPlaceQueen = board[row][col];
            if(canPlaceQueen == 0) {
                // component placeQueen = PlaceAQueen(board, row, col);
                // placeQueen.n <== n;
                // placeQueen.board <== board;
                for (var j = 0; j < n; j++) {
                    // mark the row
                    board[row][j] = 1;
                    // mark the column
                    board[j][col] = 1;

                    // mark the diagonals
                    if (row + j < n && col + j < n) {
                        board[row + j][col + j] = 1;
                    }
                    if (row - j >= 0 && col + j < n) {
                        board[row - j][col + j] = 1;
                    }
                    if (row + j < n && col - j >= 0) {
                        board[row + j][col - j] = 1;
                    }
                    if (row - j >= 0 && col - j >= 0) {
                        board[row - j][col - j] = 1;
                    }
                }
            } else {
                flag = 1;
            }
        }
    }

    signal occupied;
    if (flag == 1) {
        occupied <-- 1;
    } else {
        // occupied <-- 0;
    }

    result <== occupied;
}

// template PlaceAQueen(row, col){
//     signal input n;
//     signal input board[8][8];

//     signal output result;

//     for (var i = 0; i < n; i++) {
//         // mark the row
//         board[row][i] = 1;
//         // mark the column
//         board[i][col] = 1;

//         // mark the diagonals;
//         if (row + i < n && col + i < n) {
//             board[row + i][col + i] = 1;
//         }
//         if (row - i >= 0 && col + i < n) {
//             board[row - i][col + i] = 1;
//         }
//         if (row + i < n && col - i >= 0) {
//             board[row + i][col - i] = 1;
//         }
//         if (row - i >= 0 && col - i >= 0) {
//             board[row - i][col - i] = 1;
//         }
//     }
// }

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