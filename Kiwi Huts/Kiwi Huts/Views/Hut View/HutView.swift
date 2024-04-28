//
//  HutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import SwiftUI

struct HutView: View {
    @EnvironmentObject var user: User
    let hut: Hut

    var body: some View {

        ScrollView {
            VStack {
                AsyncImage(url: URL(string: hut.introductionThumbnail)) { phase in
                    if let image = phase.image {
                        image.aspectRatio(contentMode: .fill) // Displays the loaded image.
                    } else if phase.error != nil {
                        Color.red // Indicates an error.
                    } else {
                        ProgressView() // Acts as a placeholder.
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .frame(width: 100)
                .padding()
                
                
                VStack {
                    Text(hut.introduction)
                }
                .padding()
                
                Spacer()
                
                HutInfoCardContainer(hut: hut)
                
                Spacer()
                
                
                HutMapCard(hut: hut)
                
            }
        }
        .navigationTitle(hut.name)
        .toolbar {
            ToolbarButtons(hut: hut)
        }
    }
}


struct HutView_Previews: PreviewProvider {
    static var previews: some View {
        let testHut = Hut(
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
        HutView(hut: testHut)
    }
}
