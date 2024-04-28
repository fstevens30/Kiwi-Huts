//
//  Kiwi_HutsApp.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import SwiftUI

@main
struct Kiwi_HutsApp: App {
    
    @StateObject var user = User(completedHuts: [], savedHuts: [])
    
    let hutsList: [Hut] // Load your Hut data here

    init() {
        // Fix title sizes to fit screen
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        
        // Load the Hut data from your JSON file
        if let jsonFileURL = Bundle.main.url(forResource: "huts", withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonFileURL)
                let decoder = JSONDecoder()
                hutsList = try decoder.decode([Hut].self, from: data)
            } catch {
                print("Error loading and decoding JSON file: \(error)")
                hutsList = [] // Handle the error case
            }
        } else {
            print("JSON file not found.")
            hutsList = [] // Handle the missing file case
        }
    }

    var body: some Scene {
        WindowGroup {
            MainTabView(hutsList: hutsList)
        }
        .environmentObject(user)
    }
}

