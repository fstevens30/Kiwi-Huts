//
//  loadHutsFromJSON.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 18/03/24.
//

import Foundation

func loadHutsFromJSONFile(named fileName: String) -> [Hut] {
    guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("JSON file not found.")
        return []
    }
    
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let huts = try decoder.decode([Hut].self, from: data)
        return huts
    } catch {
        print("Error parsing JSON file: \(error)")
        return []
    }
}
