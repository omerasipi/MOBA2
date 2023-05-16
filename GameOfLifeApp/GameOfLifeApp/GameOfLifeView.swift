//
// Created by Armando Shala on 08.05.23.
//

import SwiftUI

struct GameOfLifeView: View {
    @EnvironmentObject var game: GameOfLife

    var body: some View {
        VStack {
            ForEach(0..<game.rows, id: \.self) { row in
                HStack {
                    ForEach(0..<game.columns, id: \.self) { column in
                        CellView(isAlive: game.grid[row][column])
                                .onTapGesture {
                                    game.toggleCell(atRow: row, atColumn: column)
                                }
                    }
                }
            }
        }
    }
}

struct CellView: View {
    let isAlive: Bool

    var body: some View {
        Text(isAlive ? "🦠" : "😷")
                .font(.largeTitle)
                .font(.system(size: 500))
                .minimumScaleFactor(0.01)
    }
}

