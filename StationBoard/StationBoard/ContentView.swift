//
//  ContentView.swift
//  StationBoard
//
//  Created by Armando Shala on 25.04.23.
//

import SwiftUI

struct StationBoard: Decodable {
    var stationboard: [BoardEntry]
}

struct BoardEntry: Decodable, Identifiable {
    // vairblan namen müssen mit den namen im json übereinstimmen!
    var category: String
    var number: String?
    var to: String
    var operator_: String
    var stop: StopEntry
    var delay: Int?

    var id: String {
        get {
            UUID().uuidString
        }
    }
    var trainName: String {
        get {
            category + (number ?? "")
        }
    }

    var departureTime: String {
        get {
            let date = Date(timeIntervalSince1970: TimeInterval(stop.departureTimestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case category, to, number, operator_ = "operator", stop
    }
}

struct StopEntry: Decodable {
    var platform: String
    var departureTimestamp: Int64
}

struct ContentView: View {
    @State var data = [BoardEntry]()
    @State var station = "Zurich"
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: { station = "Zurich"; self.loadData() }, label: { Text("Zurich") })
                Button(action: { station = "Winterthur"; self.loadData() }, label: { Text("Winterthur") })
            }

            List(data) { entry in
                NavigationLink(destination: DetailView(entry: entry)) {
                    HStack {
                        VStack {
                            Text(entry.trainName)
                            Text(entry.departureTime).bold()
                        }
                        Spacer()
                        Text(entry.operator_)
                        Spacer()
                        VStack{
                            Text(entry.to)
                            Text(entry.stop.platform).bold()
                        }
                    }
                }
            }
                    .onAppear() {
                        self.loadData()
                    }
                    .refreshable() {
                        self.loadData()
                    }
                    .navigationTitle(station)
        }
    }

    func loadData() {
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://transport.opendata.ch/v1/stationboard?station=\(station)")
                let jsonData = try Data(contentsOf: url!)

                let decoder = JSONDecoder()

                data = try decoder.decode(StationBoard.self, from: jsonData).stationboard

            } catch {
                fatalError("Couldn't load file from main bundle:\n\(error)")
            }
        }
    }
}

struct DetailView: View {
    var entry: BoardEntry
    var body: some View {
        Text(entry.to)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
