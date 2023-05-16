//
// Created by Armando Shala on 07.05.23.
//

import SwiftUI

struct DetailView: View {
    @State var tracks: [Track]
    @State var collectionId: Int
    var collectionName: String
    var releaseYear: String
    @State var artworkUrl: String

    var body: some View {
        VStack {
            Text(collectionName).font(.title)
            Text(releaseYear).font(.subheadline)
            AsyncImage(url: URL(string: artworkUrl)) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            List {
                ForEach(tracks, id: \.self) { track in
                    HStack {
                        Text(String(track.trackNumber ?? 0))
                        Text(track.trackName ?? "Unknown")
                        Spacer()
                        Text(track.duration ?? "Unknown")
                    }
                }
            }
        }
                .onAppear {
                    Task {
                        do {
                            // set tracks to the result of loadData where "wrapperType" == "track"
                            tracks = try await loadData(url: "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song")
                            self.artworkUrl = tracks.first(where: { $0.wrapperType == "collection" })?.artworkUrl100
                                    ?? tracks.first(where: { $0.wrapperType == "collection" })?.artworkUrl60
                                    ?? ""
                            tracks.removeAll(where: { $0.wrapperType == "collection" })

                            // get artworkUrl from wrapperType == "collection"

                        } catch {
                            print(error)
                        }
                    }
                }
    }

    func loadData(url: String) async throws -> [Track] {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL")
        }

        let urlRequest = URLRequest(url: url)

        let (data, response): (Data, URLResponse)
        (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }

        let decodedResponse = try JSONDecoder().decode(JsonResponseTrack.self, from: data)
        return decodedResponse.results
    }

}