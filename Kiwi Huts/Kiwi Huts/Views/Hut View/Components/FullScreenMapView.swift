//
//  FullScreenMapView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 29/04/2024.
//

import SwiftUI
import MapKit

struct FullScreenMapView: View {
    let hut: Hut
    
    var body: some View {
        let hutCoord = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
        VStack {
            
            Map(initialPosition: .region(MKCoordinateRegion(center: hutCoord, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)))) {
                Annotation(hut.name, coordinate: hutCoord) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.orange)
                        Image(systemName: "house.fill")
                            .foregroundStyle(Color(UIColor.systemBackground))
                            .padding(5)
                    }
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .navigationTitle(hut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
