//
// Created by Armando Shala on 08.05.23.
//

import Foundation

struct Cell: Identifiable {
    let id = UUID()
    var isAlive: Bool

    init(isAlive: Bool) {
        self.isAlive = isAlive
    }

    mutating func toggle() {
        isAlive.toggle()
    }

    func isDead() -> Bool {
        return !isAlive
    }

}
