//
//  User.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 18/03/24.
//

import Foundation
import SwiftUI

enum AccentColor: String, CaseIterable, Codable {
    case orange
    case green
    case yellow
    case pink

    var assetName: String {
        switch self {
        case .orange: return "AccentColorOrange"
        case .green: return "AccentColorGreen"
        case .yellow: return "AccentColorYellow"
        case .pink: return "AccentColorPink"
        }
    }
}

enum MapType: String, CaseIterable, Codable {
    case standard
    case satellite
    case hybrid

    var displayName: String {
        switch self {
        case .standard: return "Standard"
        case .satellite: return "Satellite"
        case .hybrid: return "Hybrid"
        }
    }
}
class User: ObservableObject {
    @Published var completedHuts: [Hut]
    @Published var savedHuts: [Hut]
    @Published var accentColor: AccentColor {
        didSet {
            saveAccentColor()
        }
    }
    @Published var mapType: MapType {
        didSet {
            saveMapType()
        }
    }

    init(completedHuts: [Hut] = [],
         savedHuts: [Hut] = [],
         accentColor: AccentColor = .orange,
         mapType: MapType = .standard) {
        self.completedHuts = completedHuts
        self.savedHuts = savedHuts
        self.accentColor = accentColor
        self.mapType = mapType
        loadData()
        loadAccentColor()
        loadMapType()
    }
    
    private func saveAccentColor() {
        UserDefaults.standard.set(accentColor.rawValue, forKey: "accentColor")
    }

    private func loadAccentColor() {
        if let rawValue = UserDefaults.standard.string(forKey: "accentColor"),
           let loadedColor = AccentColor(rawValue: rawValue) {
            self.accentColor = loadedColor
        }
    }
    
    private func saveMapType() {
        UserDefaults.standard.set(mapType.rawValue, forKey: "preferredMapType")
        }

        private func loadMapType() {
            if let rawValue = UserDefaults.standard.string(forKey: "preferredMapType"),
               let savedMapType = MapType(rawValue: rawValue) {
                self.mapType = savedMapType
            }
        }

    func saveData() {
        let encoder = JSONEncoder()
        do {
            // Save huts
            let encodedCompletedHuts = try encoder.encode(completedHuts)
            let encodedSavedHuts = try encoder.encode(savedHuts)
            UserDefaults.standard.set(encodedCompletedHuts, forKey: "completedHuts")
            UserDefaults.standard.set(encodedSavedHuts, forKey: "savedHuts")

            // Save accent color and preferred map type
            UserDefaults.standard.set(accentColor.rawValue, forKey: "accentColor")
            UserDefaults.standard.set(mapType.rawValue, forKey: "preferredMapType")
        } catch {
            print("Failed to encode user data: \(error)")
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

        // Load accent color
        if let accentColorRawValue = UserDefaults.standard.string(forKey: "accentColor"),
           let savedAccentColor = AccentColor(rawValue: accentColorRawValue) {
            accentColor = savedAccentColor
        }

        // Load preferred map type
        if let mapTypeRawValue = UserDefaults.standard.string(forKey: "preferredMapType"),
           let savedMapType = MapType(rawValue: mapTypeRawValue) {
            mapType = savedMapType
        }
    }
}
