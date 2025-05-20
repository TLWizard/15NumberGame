//
//  Board.swift
//  15NumberGame
//
//  Created by Tushar Lanka on 5/19/25.
//

import Foundation
import SwiftUI

struct Board: View {
    let gridSize: CGFloat = 300.0 // Total size of the grid area
    let numCells: Int = 4        // Number of cells per row/column
    let cellSpacing: CGFloat = 4.0 // Spacing between cells
    @StateObject var board = BoardController()
    
    var cellSize: CGFloat {
        // Calculate cell size based on total grid size, number of cells, and total spacing
        // Total spacing = (numCells - 1) * cellSpacing
        // Remaining space for cells = gridSize - totalSpacing
        // Cell size = Remaining space for cells / numCells
        (gridSize - (CGFloat(numCells - 1) * cellSpacing)) / CGFloat(numCells)
    }
    
    var body: some View {
        VStack { // This VStack might not be needed unless you have other content outside the grid
            Rectangle()
                .fill(.black.opacity(0.7))
                .frame(width: gridSize, height: gridSize)
                .overlay(
                    VStack(alignment: .center, spacing: cellSpacing) { // Apply vertical spacing
                        ForEach(0..<numCells, id: \.self) { i in
                            RowView(
                                observedBoard: board,
                                numCells: numCells,
                                cellSize: cellSize,
                                cellSpacing: cellSpacing,
                                row: i
                            )
                        }
                    }
                )
        }
    }
}

struct RowView: View {
    @ObservedObject var observedBoard: BoardController
    let numCells: Int
    let cellSize: CGFloat
    let cellSpacing: CGFloat
    let row: Int
    
    
    var body: some View {
        HStack(spacing: cellSpacing) { // Apply horizontal spacing
            ForEach(0..<numCells, id: \.self) { column in
                let intValue: Int = observedBoard.board.grid[row][column]
                let isCorrectPosition = observedBoard.isInRightPosition(row, column)

                // ALWAYS render a Rectangle with the desired frame
                Rectangle()
                    // Decide the background color based on whether it's blank or solved/unsolved
                    .fill(intValue == 0 ? .clear : (isCorrectPosition ? .green : .blue)) // Use .gray for blank or .clear if you want transparency
                    .frame(width: cellSize, height: cellSize)
                    .overlay( // Use an overlay to conditionally show the number
                        Group { // Use a Group to conditionally include content
                            if intValue != 0 { // Only show the number if it's not the blank tile (0)
                                Text("\(intValue)")
                                    .font(.title2) // Or .largeTitle, etc.
                                    .foregroundColor(.white) // Text color
                            }
                            // If intValue is 0, the Group is empty, so no text is overlaid
                        }
                    )
                // No 'else' block needed here anymore, as the Rectangle is always rendered.
            }
        }
    }
}

#Preview {
    Board()
}
