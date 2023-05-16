//
// Created by Armando Shala on 07.05.23.
//


struct JsonResponseTrack: Decodable {
    var resultCount: Int
    var results: [Track]
}


struct Track: Codable, Hashable {
    let wrapperType: String
    let kind: String?
    let artistId: Int
    let collectionId: Int
    let trackId: Int?
    let artistName: String
    let collectionName: String
    let trackName: String?
    let collectionCensoredName: String
    let trackCensoredName: String?
    let artistViewUrl: String
    let collectionViewUrl: String
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double
    let trackPrice: Double?
    let releaseDate: String
    let collectionExplicitness: String
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int
    let trackNumber: Int?
    var trackTimeMillis: Int?
    var duration: String {
        get {
            let seconds = trackTimeMillis! / 1000
            let minutes = seconds / 60
            let secondsLeft = seconds % 60
            return String(format: "%02d:%02d", minutes, secondsLeft)
        }
    }
    let country: String
    let currency: String
    let primaryGenreName: String
    let isStreamable: Bool?
}
