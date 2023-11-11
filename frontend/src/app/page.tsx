"use client";
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { useState } from 'react';

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center gap-10 p-24">
      <ConnectButton />
      <Chessboard/>
    </main>
  )
}

const Chessboard = () => {
  const rows = Array.from({ length: 8 });
  const cols = Array.from({ length: 8 });
  const [placedQueens, setPlacedQueens] = useState<{i: number; j: number}[]>([]);
  return (
    <div className="flex flex-wrap">
      {rows.map((_, rowIndex) => {
        return (
          <div key={rowIndex}>
            {cols.map((_, colIndex) => {
              const isEvenRow = rowIndex % 2 === 0;
              const isEvenCol = colIndex % 2 === 0;
              const isWhiteSquare = (isEvenRow && isEvenCol) || (!isEvenRow && !isEvenCol);

              const isQueenPlaced = placedQueens.some((queen) => queen.i === rowIndex && queen.j === colIndex);
              return (
                <div
                  key={`${rowIndex}-${colIndex}`}
                  className={`w-12 h-12 ${isWhiteSquare ? 'bg-white' : 'bg-black'} flex justify-center items-center text-3xl cursor-pointer`}
                  onClick={() => {
                    if (!isQueenPlaced) {
                    setPlacedQueens([...placedQueens, {i: rowIndex, j: colIndex}]);} else {
                      setPlacedQueens(placedQueens.filter((queen) => !(queen.i === rowIndex && queen.j === colIndex)));
                    }
                  
                  }}
                >{isQueenPlaced && "👸"}</div>
              )
            })}
          </div>)
        }
      )}
    </div>
  );
};