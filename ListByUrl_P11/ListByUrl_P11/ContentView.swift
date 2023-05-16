//
//  ContentView.swift
//  ListByUrl_P11
//
//  Created by Armando Shala on 06.05.23.
//
//

import SwiftUI


struct JsonResponse: Decodable {
    var resultCount: Int
    var results: [Album]
}

struct Album: Codable, Identifiable, Hashable {
    var id: Int {
        get {
            UUID().uuidString.hashValue
        }
    }
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
    let releaseDate: String
    let primaryGenreName: String
}


struct ContentView: View {
    @State var data = [Album]()
    @State private var searchText = ""
    @State var searchQuery = "50 Cent"

    private var searchResults: [Album] {
        if searchText.isEmpty {
            return data
        } else {
            return data.filter {
                $0.collectionName.contains(searchText)
            }
        }
    }

    var body: some View {
        VStack {
            Text("Search for a band:")
            TextField(
                    "Search for a band",
                    text: $searchQuery,
                    onCommit: {
                        Task {
                            await loadData()
                        }
                    })
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
        }

        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults, id: \.self) { album in
                        HStack {
                            // add image from album.artworkUrl60
                            AsyncImage(url: URL(string: album.artworkUrl60)) { image in
                                image.fixedSize().frame(width: 60, height: 60)
                            } placeholder: {
                                ProgressView()
                            }
                            VStack(alignment: .leading) {
                                Text(album.collectionName).font(.headline)
                                Text(album.artistName).font(.subheadline)
                            }
                        }
                    }
                }
                        .listStyle(.plain)
                        .navigationTitle("Search for \(searchQuery)")
                        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                ForEach(searchResults, id: \.self) { album in
                    Text(album.collectionName).searchCompletion(album)
                }
            }
                    .task {
                        await loadData()
                    }

        }

    }

    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchQuery.lowercased().replacingOccurrences(of: " ", with: "+"))&entity=album") else {
            print("Invalid URL")
            return
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response): (Data, URLResponse)
            (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error while fetching data")
            }

            let decodedResponse = try JSONDecoder().decode(JsonResponse.self, from: data)
            self.data = decodedResponse.results
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
