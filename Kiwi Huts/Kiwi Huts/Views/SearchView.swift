//
//  SearchView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI


struct SearchView: View {
    @EnvironmentObject var user: User
    var huts: [Hut]
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
                        }                }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Hut Type", selection: $selectedHutType) {
                        Text("All Hut Types").tag("All")
                        ForEach(uniqueHutTypes, id: \.self) { hutType in
                            Text(hutType).tag(hutType)
                        }                }
                    .pickerStyle(MenuPickerStyle())
                }
                List {
                    ForEach(searchResults) { hut in
                        NavigationLink(destination: HutView(hut: hut)) {
                            ListedHutView(hut: hut)
                        }
                    }
                }
            }
            .navigationTitle("Search Huts")
            .searchable(text: $searchText)
        }
    }
    
    var uniqueRegions: [String] {
        let regions = huts.compactMap { $0.region }
        return Array(Set(regions)).sorted()
    }
    
    var uniqueHutTypes: [String] {
        let hutTypes = huts.compactMap { $0.hutCategory }
        return Array(Set(hutTypes)).sorted()
    }
    
    var searchResults: [Hut] {
        var results = huts
        if !searchText.isEmpty {
            results = results.filter { $0.name.contains(searchText) || ($0.region.contains(searchText)) || ($0.locationString?.contains(searchText) ?? false) }
        }
        if selectedRegion != "All" {
            results = results.filter { $0.region == selectedRegion }
        }
        if selectedHutType != "All" {
            results = results.filter { $0.hutCategory == selectedHutType }
        }
        return results.sorted { $0.name < $1.name }
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy user and hutsList for the preview
        let dummyHut = Hut(id: "1", name: "Hut1", status: "OPEN", region: "Region1", y: 1, x: 1, locationString: nil, numberOfBunks: nil, facilities: nil, hutCategory: "Standard", proximityToRoadEnd: nil, bookable: false, introduction: "Introduction", introductionThumbnail: "Thumbnail", staticLink: "Link", place: nil, lon: 1.0, lat: 1.0)
        let hutsList = [dummyHut, dummyHut, dummyHut, dummyHut, dummyHut]

        SearchView(huts: hutsList)
            .environmentObject(User(completedHuts: [dummyHut, dummyHut, dummyHut], savedHuts: [dummyHut, dummyHut, dummyHut]))
    }
}

