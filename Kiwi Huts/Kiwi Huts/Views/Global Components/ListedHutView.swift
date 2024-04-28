//
//  ListedHutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 18/03/2024.
//

import SwiftUI

struct ListedHutView: View {
    @EnvironmentObject var user: User
    let hut: Hut

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: hut.introductionThumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 75) // Adjust these values to your preference
                        .clipped()
                }
                else {
                    Image(systemName: "house.fill")
                        .frame(width: 100, height: 75)
                        .clipped()
                }
            }
            .padding()

            VStack(alignment: .leading) {
                Text(hut.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(hut.region)
                    .font(.subheadline)
                    .foregroundStyle(Color.accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
            }
            Spacer()
        }
        .swipeActions(allowsFullSwipe: false) {
            Button {
                // save the hut to the User.completedHuts list
                user.completedHuts.append(hut)
                user.saveData()
            } label: {
                Label("Complete", systemImage: "checkmark.circle.fill")
            }
            .tint(.green)
            
            Button {
                // save the hut to the User.savedHuts list
                user.savedHuts.append(hut)
                user.saveData()
            } label: {
                Label("Save", systemImage: "star.circle.fill")
            }
            .tint(.yellow)
        }
    }
}


struct ListedHutView_Previews: PreviewProvider {
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
        ListedHutView(hut: testHut)
    }
}
