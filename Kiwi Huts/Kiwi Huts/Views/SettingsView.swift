//
//  SettingsView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 13/12/2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var viewModel: HutsViewModel
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        Text("Color Theme")
                        Spacer()
                        Picker("", selection: $user.accentColor) {
                            ForEach(AccentColor.allCases, id: \.self) { color in
                                Text(color.rawValue.capitalized)
                                    .tag(color)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        
                    }
                    HStack {
                        Text("Default Map Style")
                        Spacer()
                        Picker("", selection: $user.mapType) {
                            ForEach(MapType.allCases, id: \.self) { mapType in
                                Text(mapType.displayName).tag(mapType)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                Spacer()
                
                if let lastUpdated = viewModel.lastUpdated {
                    Text("Data last updated: \(formatDate(lastUpdated))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    Text("No data yet")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationTitle("Settings")
        }
    }
}
