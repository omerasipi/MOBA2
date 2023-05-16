//
// Created by Armando Shala on 07.05.23.
//

import Foundation

struct JsonResponseAlbum: Decodable {
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
    var releaseYear: String {
        get {
            String(releaseDate.prefix(4))
        }
    }
    let primaryGenreName: String
}
