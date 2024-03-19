//
//  HutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import SwiftUI
import MapKit

struct HutView: View {
    @EnvironmentObject var user: User
    let hut: Hut
    
    var body: some View {
        let hutCoord = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
        
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


            
            Text(hut.introduction)
            
            Spacer()
            
            HStack {
                Button(action: {
                    if !user.savedHuts.contains(where: { $0.id == hut.id }) {
                        user.savedHuts.append(hut)
                    }
                }) {
                    Text("Save Hut")
                }
                .buttonStyle(.bordered)
                Button(action: {
                    if !user.completedHuts.contains(where: { $0.id == hut.id }) {
                        user.completedHuts.append(hut)
                    }
                }) {
                    Text("Mark Complete")
                }
                .buttonStyle(.borderedProminent)
            }
            
            Map(initialPosition: .region(MKCoordinateRegion(center: hutCoord, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)))) {
                Annotation(hut.name, coordinate: hutCoord) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.orange)
                        Image(systemName: "house.fill")
                            .padding(5)
                    }
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
        }
        .navigationTitle(hut.name)
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
