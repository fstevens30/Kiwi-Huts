//
//  HutListView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct HutListView: View {
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @EnvironmentObject var user: User
    @EnvironmentObject var viewModel: HutsViewModel
    
    @State private var searchText = ""
    @State private var selectedRegion: String = "All"
    @State private var selectedHutType: String = "All"
    
    var body: some View {
        ZStack {
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
                    .padding()

                    List {
                        ForEach(searchResults, id: \.id) { hut in
                            NavigationLink(destination: HutView(hut: hut)) {
                                ListedHutView(hut: hut, showToast: $showToast, toastMessage: $toastMessage)
                            }
                        }
                    }
                }
                .navigationTitle("Huts")
                .searchable(text: $searchText)
                .autocorrectionDisabled(true)
                .onAppear {
                    print("Total huts available: \(viewModel.hutsList.count)")
                }
            }
            
            VStack {
                Spacer()
                if showToast {
                    Toast(message: toastMessage)
                        .transition(.slide)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                        }
                }
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
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        var results = viewModel.hutsList
            .filter {
                (trimmedSearchText.isEmpty ||
                 $0.name.localizedCaseInsensitiveContains(trimmedSearchText) ||
                 $0.region?.localizedCaseInsensitiveContains(trimmedSearchText) ?? false ||
                 $0.locationString?.localizedCaseInsensitiveContains(trimmedSearchText) ?? false)
            }
            .filter { selectedRegion == "All" || $0.region == selectedRegion }
            .filter { selectedHutType == "All" || $0.hutCategory == selectedHutType }

        if trimmedSearchText.isEmpty {
            results.shuffle()
        } else {
            results.sort { $0.name < $1.name }
        }

        return results
    }
}
