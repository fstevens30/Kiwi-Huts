//
//  User.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 18/03/24.
//

import Foundation

class User: ObservableObject {
    @Published var completedHuts: [Hut]
    @Published var savedHuts: [Hut]

    init(completedHuts: [Hut], savedHuts: [Hut]) {
        self.completedHuts = completedHuts
        self.savedHuts = savedHuts
    }
}
