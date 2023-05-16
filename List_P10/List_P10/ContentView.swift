//
//  ContentView.swift
//  List_P10
//
//  Created by Armando Shala on 06.05.23.
//
//

import SwiftUI

struct ContentView: View {
    // a state variable to hold the actual data (so in this case individual albums)
    @State private var albums = [AlbumRepresentation]()
    var body: some View {

        NavigationView {
            List {
                ForEach(albums) {
                    album in
                    VStack(alignment: .leading) {
                        Text(album.collectionName).font(.headline)
                        Text(album.artistName).font(.subheadline)
                    }
                }
            }
        }
                .onAppear(perform: loadData)
                .refreshable(action: loadData)
    }

    func loadData() {
        DispatchQueue.global().async {
            guard let file = Bundle.main.url(forResource: "stones", withExtension: "json") else {
                fatalError("Couldn't find stones.json in main bundle.")
            }
            do {
                let jsonData = try Data(contentsOf: file)
                // check the structure of the json file: the results
                let songs = try JSONDecoder().decode(JsonRepresentation.self, from: jsonData).results
                DispatchQueue.main.async {
                    self.albums = songs
                }
            } catch {
                fatalError("Couldn't load file from main bundle:\n\(error)")
            }
        }
    }

}

struct JsonRepresentation: Decodable {
    // this represents the outermost level of the json file. Each variable name and type must match the corresponding key in the json
    let resultCount: Int
    let results: [AlbumRepresentation]
}

struct AlbumRepresentation: Identifiable, Decodable {
    // this represents the level of the results array. Each variable name and type must match the corresponding key in the json
    let id = UUID()
    let wrapperType: String
    let collectionType: String
    let artistId: Int
    let collectionId: Int
    let amgArtistId: Int?
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let artistViewUrl: String?
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String
    let country: String
    let currency: String
    var releaseDate: String {
        get {
            let date = Date(timeIntervalSince1970: TimeInterval(releaseDate) ?? Date().timeIntervalSinceNow)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: date)
        }
    }
    let primaryGenreName: String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
