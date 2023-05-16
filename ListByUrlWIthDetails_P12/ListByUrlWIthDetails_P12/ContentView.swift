//
//  ContentView.swift
//  ListByUrl_P11
//
//  Created by Armando Shala on 06.05.23.
//
//

import SwiftUI

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
        NavigationStack {
            VStack {
                Text("Search for a band:")
                TextField(
                        "Search for a band",
                        text: $searchQuery,
                        onCommit: {
                            Task {
                                do {
                                    try await loadData(url: "https://itunes.apple.com/search?term=\(searchQuery.lowercased().replacingOccurrences(of: " ", with: "+"))&entity=album")
                                } catch {
                                    print(error)
                                }
                            }
                        })
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
            }

            VStack {
                List(data) { album in
                    NavigationLink(destination: DetailView(tracks: [], collectionId: album.collectionId, collectionName: album.collectionName, releaseYear: album.releaseYear, artworkUrl: album.artworkUrl100)) {
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
            }
            ForEach(searchResults, id: \.self) { album in
                Text(album.collectionName).searchCompletion(album)
            }
        }
                .task {
                    do {
                        data = try await loadData(url: "https://itunes.apple.com/search?term=\(searchQuery.lowercased().replacingOccurrences(of: " ", with: "+"))&entity=album")
                    } catch {
                        print("Error while loading data")
                    }
                }

    }


    public func loadData(url: String) async throws -> [Album] {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return [Album]()
        }

        let urlRequest = URLRequest(url: url)

            let (data, response): (Data, URLResponse)
            (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error while fetching data")
            }

            let decodedResponse = try JSONDecoder().decode(JsonResponseAlbum.self, from: data)
            return decodedResponse.results
    }
}
