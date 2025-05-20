//
//  PuzzleBoard.swift
//  15NumberGame
//
//  Created by Tushar Lanka on 5/16/25.
//

import Foundation

public struct PuzzleBoard {
    public var grid: [[Int]]
    
    public init() {
        let rows    = 4
        let columns = 4
        self.grid = Array(                     // type: [[Int]]
            repeating: Array(repeating: 0,    // each cell starts as 0
                             count: columns),
            count: rows
        )
    }
}

final class BoardController: ObservableObject {
    @Published var board: PuzzleBoard = .init()

    func generateBoard() {
        var tempArray: [Int]
        var solvable = false

        repeat {
            tempArray = Array(0..<16).shuffled()
            
            let blankIndex = tempArray.firstIndex(of: 0)!
            let zeroRowFromTop = blankIndex / 4               
            let rowFromBottom = 4 - zeroRowFromTop

            solvable = checkIfBoardIsSolvable(rowFromBottom, tempArray)
        } while !solvable

        for i in 0..<4 {
            for j in 0..<4 {
                board.grid[i][j] = tempArray[i*4 + j]
            }
        }
    }

    private func checkIfBoardIsSolvable(_ rowFromBottom: Int, _ tiles: [Int]) -> Bool {
        var invCount = 0
        for i in 0..<tiles.count - 1 {
            for j in i + 1..<tiles.count {
                if tiles[i] != 0 && tiles[j] != 0 && tiles[i] > tiles[j] {
                    invCount += 1
                }
            }
        }

        let rowEven = (rowFromBottom % 2 == 0)
        let invEven = (invCount % 2 == 0)
        return rowEven != invEven
    }
    
    
}

