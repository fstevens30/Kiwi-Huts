//
//  HutListView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct HutListView: View {
    var huts: [Hut]
    
    var body: some View {
        VStack {
            NavigationView {
                
                List(huts.shuffled()) { hut in
                    NavigationLink(destination: HutView(hut: hut)) {
                        HStack {
                            VStack {
                                Text(hut.name)
                                Text(hut.region)
                            }
                        }
                    }
                }
                .navigationTitle("Huts")
            }
        }
    }
}

struct HutListView_Previews: PreviewProvider {
    static var previews: some View {
        let testHutList = [
            Hut(
                id: "100033374",
                name: "Luxmore Hut  ",
                status: "OPEN",
                region: "Fiordland",
                y: 4960153,
                x: 1178767,
                locationString: "Fiordland National Park",
                numberOfBunks: 54,
                facilities: [
                    "Cooking",
                    "Heating",
                    "Mattresses",
                    "Lighting",
                    "Toilets - flush",
                    "Water from tap - not treated, boil before use",
                    "Water supply"
                ],
                hutCategory: "Great Walk",
                proximityToRoadEnd: nil,
                bookable: true,
                introduction: "This is a 54 bunk, Great Walk hut on the Kepler Track, Fiordland. Bookings required in the Great Walks season. ",
                introductionThumbnail: "https://www.doc.govt.nz/thumbs/large/link/262b915193334eaba5bd07f74999b664.jpg",
                staticLink: "https://www.doc.govt.nz/link/dc756fa57891438b8f3fa03813fb7260.aspx",
                place: "Fiordland National Park",
                lon: 167.619159,
                lat: -45.385232
            )
        ]
        
        HutListView(huts: testHutList)
    }
}
