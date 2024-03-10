//
//  HutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import SwiftUI
import MapKit

struct HutView: View {
    let hut: Hut
    
    var body: some View {
        let hutCoord = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
        
        VStack {
            Text(hut.name)
                .font(.title)
            
            Spacer()
            
            AsyncImage(url: URL(string: hut.thumbnailURL)) { phase in
                if let image = phase.image {
                    image.aspectRatio(contentMode: .fill) // Displays the loaded image.
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    ProgressView() // Acts as a placeholder.
                }
            }


            
            Text(hut.introduction)
            Map {
                Annotation(hut.name, coordinate: hutCoord) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.orange)
                        Image(systemName: "house.fill")
                            .padding(5)
                    }
                }
            }
            .mapStyle(.hybrid)
        }
    }
}

struct HutView_Previews: PreviewProvider {
    static var previews: some View {
        let testHut = Hut(
            assetID: "100033374",
            bookable: true,
            hutCategory: "Great Walk",
            introduction: "This is a 54 bunk, Great Walk hut on the Kepler Track, Fiordland. Bookings required in the Great Walks season. ",
            thumbnailURL: "https://www.doc.govt.nz/thumbs/hero/globalassets/images/places/fiordland/luxmore-hut/luxmore-hut-1920.jpg",
            lat: -45.385232,
            lon: 167.619159,
            name: "Luxmore Hut",
            staticLink: "https://www.doc.govt.nz/link/dc756fa57891438b8f3fa03813fb7260.aspx",
            status: "OPEN",
            x: 1178767,
            y: 4960153
        )
        
        HutView(hut: testHut)
    }
}
