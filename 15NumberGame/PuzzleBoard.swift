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
    // to check if board is in right position
    private let solved: [Int] = Array(1...15) + [0]
    private var oneDimensionalBoard: [Int] = Array(0...15)
    
    init(){
        generateBoard()
    }

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
        oneDimensionalBoard = tempArray
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
    
    func isInRightPosition(_ row: Int, _ column: Int) -> Bool{
        
        return solved[row*4 + column] == board.grid[row][column]
    }
    
    func checkIfEdge(_ row: Int, _ column: Int) -> Bool{
        return column == 0 || column == 3 || row == 0 || row == 3
    }
    func makeMove(_ row: Int, _ column: Int){
        let tile = row*4 + column
        let temp = oneDimensionalBoard[tile]
        
        if oneDimensionalBoard[tile + 4] == 0{
            oneDimensionalBoard[tile] = 0
            board.grid[row][column] = 0
            oneDimensionalBoard[tile + 4] = temp
            board.grid[row+1][column] = temp
        }
        
        if oneDimensionalBoard[tile - 4]  == 0{
            oneDimensionalBoard[tile] = 0
            board.grid[row][column] = 0
            oneDimensionalBoard[tile - 4] = temp
            board.grid[row-1][column] = temp
        }
        
        if oneDimensionalBoard[tile + 1] == 0{
            oneDimensionalBoard[tile] = 0
            board.grid[row][column] = 0
            oneDimensionalBoard[tile + 1] = temp
            board.grid[row][column+1] = temp
        }
        if oneDimensionalBoard[tile - 1] == 0{
            oneDimensionalBoard[tile] = 0
            board.grid[row][column] = 0
            oneDimensionalBoard[tile - 1] = temp
            board.grid[row][column-1] = temp
        }
    }
    
    
}

