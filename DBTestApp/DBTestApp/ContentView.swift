//
//  DBModel.swift
//  DBTestApp
//
//  Created by Armando Shala on 09.05.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = DBModel()
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var country: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Country", text: $country)
                Button("Add") {
                    let user = User(id: 1, firstName: firstName, lastName: lastName, country: country)
                    model.insertUser(user: user)
                    model.getUsers()
                }
            }
            List(model.users) { user in
                HStack {
                    Text(user.firstName)
                    Text(user.lastName)
                    Text(user.country)
                }
            }
        }
                .padding()
                .onAppear {
                    model.initDatabase()
                }
                .alert("Error", isPresented: $model.presentAlert, actions: {
                    Button("OK") {
                    }
                },
                        message: { Text(model.errorMessage) })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
