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
    
    init(completedHuts: [Hut] = [], savedHuts: [Hut] = []) {
        self.completedHuts = completedHuts
        self.savedHuts = savedHuts
        loadData() // Load saved data
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let encodedCompletedHuts = try encoder.encode(completedHuts)
            let encodedSavedHuts = try encoder.encode(savedHuts)
            UserDefaults.standard.set(encodedCompletedHuts, forKey: "completedHuts")
            UserDefaults.standard.set(encodedSavedHuts, forKey: "savedHuts")
        } catch {
            print("Failed to encode huts: \(error)")
        }
    }
    
    func loadData() {
        let decoder = JSONDecoder()
        if let savedCompletedHuts = UserDefaults.standard.object(forKey: "completedHuts") as? Data,
           let savedSavedHuts = UserDefaults.standard.object(forKey: "savedHuts") as? Data {
            do {
                completedHuts = try decoder.decode([Hut].self, from: savedCompletedHuts)
                savedHuts = try decoder.decode([Hut].self, from: savedSavedHuts)
            } catch {
                print("Failed to decode huts: \(error)")
            }
        }
    }}
