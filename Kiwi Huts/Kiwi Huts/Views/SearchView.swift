//
//  SearchView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var viewModel: HutsViewModel
    @State private var searchText = ""
    @State private var selectedRegion: String = "All"
    @State private var selectedHutType: String = "All"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Picker("Region", selection: $selectedRegion) {
                        Text("All Regions").tag("All")
                        ForEach(uniqueRegions, id: \.self) { region in
                            Text(region).tag(region)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Hut Type", selection: $selectedHutType) {
                        Text("All Hut Types").tag("All")
                        ForEach(uniqueHutTypes, id: \.self) { hutType in
                            Text(hutType).tag(hutType)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                List {
                    ForEach(searchResults, id: \.id) { hut in
                        NavigationLink(destination: HutView(hut: hut)) {
                            ListedHutView(hut: hut)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
            .autocorrectionDisabled(true)
            .onAppear {
                print("Total huts available: \(viewModel.hutsList.count)")
            }
        }
    }
    
    var uniqueRegions: [String] {
        let regions = viewModel.hutsList.compactMap { $0.region }
        let unique = Array(Set(regions)).sorted()
        print("Unique Regions: \(unique)")
        return unique
    }
    
    var uniqueHutTypes: [String] {
        let hutTypes = viewModel.hutsList.compactMap { $0.hutCategory }
        let unique = Array(Set(hutTypes)).sorted()
        print("Unique Hut Types: \(unique)")
        return unique
    }
    
    var searchResults: [Hut] {
        var results = viewModel.hutsList
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        print("Initial huts list count: \(results.count)")

        if !trimmedSearchText.isEmpty {
            results = results.filter {
                $0.name.localizedCaseInsensitiveContains(trimmedSearchText) ||
                $0.region?.localizedCaseInsensitiveContains(trimmedSearchText) ?? false ||
                $0.locationString?.localizedCaseInsensitiveContains(trimmedSearchText) ?? false
            }
            print("Filtered by text count: \(results.count)")
        }
        if selectedRegion != "All" {
            results = results.filter { $0.region == selectedRegion }
            print("Filtered by region count: \(results.count)")
        }
        if selectedHutType != "All" {
            results = results.filter { $0.hutCategory == selectedHutType }
            print("Filtered by hut type count: \(results.count)")
        }
        return results.sorted { $0.name < $1.name }
    }
}
