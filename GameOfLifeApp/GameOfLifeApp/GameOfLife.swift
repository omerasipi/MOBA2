//
// Created by Armando Shala on 08.05.23.
//

import Foundation

class GameOfLife: ObservableObject {
    @Published var grid: [[Bool]]
    @Published var generation = 0
    @Published var stableGenerationCount = 0

    var rows: Int
    var columns: Int

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }

    func toggleCell(atRow row: Int, atColumn column: Int) {
        grid[row][column].toggle()
    }

    func nextGeneration() {
        var newGrid = grid
        for row in 0..<rows {
            for column in 0..<columns {
                let livingNeighbors = countLivingNeighbors(atRow: row, atColumn: column)
                if grid[row][column] {
                    newGrid[row][column] = livingNeighbors == 2 || livingNeighbors == 3
                } else {
                    newGrid[row][column] = livingNeighbors == 3
                }
            }
        }
        if newGrid == grid {
            stableGenerationCount += 1
            if stableGenerationCount == 5 {
                NotificationCenter.default.post(name: .gameOfLifeNoLivingCells, object: nil)
            }
        } else {
            stableGenerationCount = 0
        }
        generation += 1
        grid = newGrid

        if !hasLivingCells() {
            NotificationCenter.default.post(name: .gameOfLifeNoLivingCells, object: nil)
        }
    }

    private func countLivingNeighbors(atRow row: Int, atColumn column: Int) -> Int {
        let offsets = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1), (0, 0), (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]

        return offsets.reduce(0) { count, offset in
            let newRow = row + offset.0
            let newColumn = column + offset.1
            if newRow >= 0 && newRow < rows && newColumn >= 0 && newColumn < columns && grid[newRow][newColumn] {
                return count + 1
            } else {
                return count
            }
        }
    }

    func hasLivingCells() -> Bool {
        for row in grid {
            for cell in row {
                if cell {
                    return true
                }
            }
        }
        return false
    }

    func randomizeGrid() {
        grid = grid.map { row in
            row.map { _ in
                Bool.random()
            }
        }
    }

    func resetGrid() {
        grid = Array(repeating: Array(repeating: false, count: columns), count: rows)
    }
}

extension Notification.Name {
    static let gameOfLifeNoLivingCells = Notification.Name("gameOfLifeNoLivingCells")
}
