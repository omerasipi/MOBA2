//
//  DBModel.swift
//  DBTestApp
//
//  Created by Armando Shala on 09.05.23.
//

import Foundation
import SQLite

class DBModel: ObservableObject {

    var db: Connection? = nil
    let idCol = Expression<Int64>("id")
    let firstNameCol = Expression<String?>("firstName")
    let lastNameCol = Expression<String?>("lastName")
    let countryIdForeignKeyCol = Expression<Int64>("country_id")
    let userTable = Table("users")


    let countryidCol = Expression<Int64>("id")
    let countryName = Expression<String>("name")
    let countryTable = Table("countries")


    @Published var users = [User]()
    @Published var presentAlert = false
    @Published var errorMessage = ""


    func initDatabase() {
        do {
            try createDatabase()
            try createTable()
            getUsers()
        } catch {
            errorMessage = "The database could not be created!"
            presentAlert = true
        }
    }


    func createDatabase() throws {
        let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true)
        //will create a database file if it is not there
        db = try Connection("\(path.first ?? "")/db.sqlite3")
    }

    func createTable() throws {
        try db?.run(userTable.create(ifNotExists: true) { t in
            //Note that primary key = true -> autoincrement!
            t.column(idCol, primaryKey: true)
            t.column(firstNameCol)
            t.column(lastNameCol)
            t.column(countryIdForeignKeyCol)
            t.foreignKey(countryIdForeignKeyCol, references: countryTable, countryidCol)
        })

        try db?.run(countryTable.create(ifNotExists: true) { t in
            t.column(countryidCol, primaryKey: true)
            t.column(countryName)
        })
    }

    func insertUser(user: User) {
        let countryId = getCountryId(country: user.country)
        do {
            let insert = userTable.insert(
                    firstNameCol <- user.firstName,
                    lastNameCol <- user.lastName,
                    countryIdForeignKeyCol <- countryId)
            let rowid = try db?.run(insert)
        } catch {
            fatalError("Could not insert user")
        }
    }

    private func getCountryId(country: String) -> Int64 {
        do {
            var res: Int64 = -1
            let query = countryTable.select(countryidCol).filter(countryName == country).limit(1)
            for countryId in try db!.prepare(query) {
                res = countryId[countryidCol]
            }

            if res == -1 {
                let insert = countryTable.insert(countryName <- country)
                res = try db!.run(insert)
            }
            return res
        } catch {
            fatalError("Could not get country id")
        }

    }

    func getUsers() {
        do {
            users.removeAll()
            for user in try db!.prepare(userTable.select(countryIdForeignKeyCol, userTable[idCol],
                    firstNameCol, lastNameCol, countryName).join(
                    countryTable, on: countryIdForeignKeyCol == countryTable[countryidCol])) {
                users.append(User(id: user[idCol],
                        firstName: user[firstNameCol] ?? "",
                        lastName: user[lastNameCol] ?? "",
                        country: user[countryName]))
            }
        } catch {
            fatalError("Could not read users")
        }
    }
}
