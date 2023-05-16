//
//  ImageModel.swift
//  ImageLoader
//
//

import Foundation

struct ImageDescription : Decodable, Identifiable {
    var id : String
    var urls : ImageURLDescription
    var alt_description : String?
    var color : String
}

struct ImageURLDescription : Decodable {
    var regular : String
}

class ImageModel : ObservableObject {

    @Published var images = [ImageDescription]()


    let urlString = "https://api.unsplash.com/photos/random?client_id=5pacHokMpnsoIpTJkGgH78mbwf0Bfa3LmDPHriDWDB8&count=14&orientation=landscape"

    func download() async throws -> Data {
        let url = URL(string: urlString)
        let jsonData = try Data(contentsOf: url!)

        return jsonData
    }

    func loadJSON() async   {
        do {
            let data = try await download()
            let decoder = JSONDecoder()
            let images = try decoder.decode([ImageDescription].self, from: data)
            print("loaded #\(images.count) images")

            await MainActor.run {
                //self.data is a State variable
                self.images = images
            }
        } catch {
            fatalError("Couldn't load file from server \(error)")
        }
    }
}
