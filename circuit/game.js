function createBoard(n) {
    return new Array(n).fill().map(() => new Array(n).fill(0));
}

function placeQueen(board, row, col) {
    if (board[row][col] === 1) {
        console.log("Cannot place queen here, position is already under threat.");
        return;
    }

    // Mark the entire row and column
    for (let i = 0; i < board.length; i++) {
        board[row][i] = 1;
        board[i][col] = 1;
    }

    // Mark diagonals
    for (let i = 0; i < board.length; i++) {
        if (row + i < board.length && col + i < board.length) board[row + i][col + i] = 1;
        if (row - i >= 0 && col + i < board.length) board[row - i][col + i] = 1;
        if (row + i < board.length && col - i >= 0) board[row + i][col - i] = 1;
        if (row - i >= 0 && col - i >= 0) board[row - i][col - i] = 1;
    }
}

function isOccupied(board, row, col) {
    return board[row][col] === 1
}

// function isOccupied(board, row, col) {
//     // Check row and column
//     for (let i = 0; i < board.length; i++) {
//         if (board[row][i] === 1 || board[i][col] === 1) {
//             return true;
//         }
//     }

//     // Check diagonals
//     for (let i = -board.length; i < board.length; i++) {
//         if (board[row + i]?.[col + i] === 1 || board[row + i]?.[col - i] === 1) {
//             return true;
//         }
//     }

//     return false;
// }

function canPlaceQueen(board, row, col) {
    return !isOccupied(board, row, col);
}

function allQueensPlaced(board) {
    let count = 0;
    for (let row of board) {
        count += row.filter(cell => cell === 1).length;
    }
    return count === board.length;
}

// Usage
let board = createBoard(8);
placeQueen(board, 0, 0); // User places a queen
console.log(canPlaceQueen(board, 1, 2)); // Check if another queen can be placed
console.log(allQueensPlaced(board)); // Check if all queens are placed