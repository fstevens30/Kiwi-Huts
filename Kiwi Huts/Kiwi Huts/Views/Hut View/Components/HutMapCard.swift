//
//  HutMapCard.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 29/04/2024.
//

import SwiftUI
import MapKit

struct HutMapCard: View {
    let hut: Hut
    
    var body: some View {
        let hutCoord = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
        
        ZStack(alignment: .topTrailing) {
            Map(initialPosition: .region(MKCoordinateRegion(center: hutCoord, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)))) {
                Annotation(hut.name, coordinate: hutCoord) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5.0)
                            .fill(Color.orange)
                        Image(systemName: "house.fill")
                            .padding(5)
                    }
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding(10)
            
            NavigationLink(destination: FullScreenMapView(hut: hut)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.gray)
                        .opacity(0.8)
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .foregroundStyle(Color.black)
                        .padding(5)
                }
                .frame(width: 50, height: 50)
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
        }
    }
}

struct MapHutCard_Previews: PreviewProvider {
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
        HutMapCard(hut: testHut)
    }
}
