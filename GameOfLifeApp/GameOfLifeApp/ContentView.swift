//
//  ContentView.swift
//  GameOfLifeApp
//
//  Created by Armando Shala on 08.05.23.
//
//

import SwiftUI

struct ContentView: View {
    @State private var selectedRows: Int = 30
    @State private var selectedColumns: Int = 15
    @State private var timer: Timer? = nil
    @StateObject private var game = GameOfLife(rows: 30, columns: 15)

    var body: some View {
        VStack {
            Text("Game of Life")
                    .font(.largeTitle)
            Text("Click on a cell to toggle it")
                    .font(.title2)
            Text("The cells did not change for 5 generation").opacity(game.stableGenerationCount == 5 ? 1 : 0)
                    .font(.title2)
                    .foregroundColor(.red)
                    .onReceive(NotificationCenter.default.publisher(for: .gameOfLifeNoLivingCells)) { _ in
                        timer?.invalidate()
                        timer = nil
                    }
            Text("Generation: \(game.generation)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            GameOfLifeView().environmentObject(game)
                    .aspectRatio(1, contentMode: .fit)
        }
        Spacer()
        HStack {
            Button("Start") {
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    game.nextGeneration()
                }
            }
            Button("Stop") {
                timer?.invalidate()
                timer = nil
            }
            Button("Next") {
                game.nextGeneration()
            }
            Button("Random") {
                resetGrid()
                game.randomizeGrid()
            }
            Button("Clear") {
                resetGrid()
            }
        }

        HStack {
            CustomPicker(title: "Rows", selection: $selectedRows, range: 1...50)
                    .onChange(of: selectedRows, perform: { value in
                        game.rows = value
                        game.resetGrid()
                    })
                    .onAppear(perform: {
                        game.rows = selectedRows
                    })
            Button("Reset", action: {
                selectedRows = 15
                selectedColumns = 15
            })
            CustomPicker(title: "Columns", selection: $selectedColumns, range: 1...50)
                    .onChange(of: selectedColumns, perform: { value in
                        game.columns = value
                        game.resetGrid()
                    })
                    .onAppear(perform: {
                        game.columns = selectedColumns
                    })
        }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: .gameOfLifeNoLivingCells, object: nil, queue: .main) { [self] _ in
                        timer?.invalidate()
                        timer = nil
                    }
                }
    }

    func resetGrid() {
        game.generation = 0
        timer?.invalidate()
        timer = nil
        game.grid = Array(repeating: Array(repeating: false, count: game.columns), count: game.rows)
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
