//
//  ContentView.swift
//  TestTT2
//
//  Created by Armando Shala on 02.05.23.
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ImageModel()

    let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 0)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(model.images) { imageDescription in
                    UnsplashImage(imageDescription: imageDescription, isShown: $model.isShown)
                }
            }
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button("Show/Hide") {
                                model.toggleShowHide()
                            }
                        }
                    }
                    .task {
                        await model.loadJSON()
                    }
                    .padding()
        }
    }
}

struct UnsplashImage: View {
    @State var imageDescription: ImageDescription
    @Binding var isShown: Bool

    var body: some View {
        AsyncImage(url: URL(string: imageDescription.urls.regular)) { image in
            image.resizable().scaledToFit().overlay(alignment: .bottom) {
                Text(imageDescription.alt_description ?? "-")
                        .foregroundColor(Color.white).background(Color(red: 12 / 255, green: 12 / 255, blue: 12 / 255, opacity: 80 / 255).padding(.horizontal, 5))

            }
        }
        placeholder: {
            ProgressView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
