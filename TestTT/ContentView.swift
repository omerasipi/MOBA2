//
// Created by Armando Shala on 02.05.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ImageModel()

    var body: some View {
        ScrollView {
            ForEach(model.images) { imageDescription in
                UnsplashImage(imageDescription: imageDescription)

            }.task{
                        await model.loadJSON()
                    }
                    .padding()
        }
    }
}

struct UnsplashImage: View{
    @State var imageDescription : ImageDescription
    var body: some View{
        AsyncImage(url: URL(string: imageDescription.urls.regular))
        { image in
            image.resizable().scaledToFit().overlay(alignment: .bottom) {
                    Text(imageDescription.alt_description ?? "-")
                            .foregroundColor(Color.white).background(Color(red: 12/255, green: 12/255, blue: 12/255, opacity: 80/255)).padding(.horizontal, 5)
                } }
        placeholder: {
            ProgressView() }
    }
}