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

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults) { hut in
                    NavigationLink(destination: HutView(hut: hut)) {
                        Text(hut.name)
                    }
                }
            }
            .navigationTitle("Search Huts")
            .searchable(text: $searchText)
        }
    }

    var searchResults: [Hut] {
        if searchText.isEmpty {
            return huts.sorted { $0.name < $1.name }
        } else {
            return huts.filter { $0.name.contains(searchText) }.sorted { $0.name < $1.name }
        }
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

