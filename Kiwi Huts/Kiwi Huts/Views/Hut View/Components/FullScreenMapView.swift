//
//  FullScreenMapView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 29/04/2024.
//

import SwiftUI
import MapKit

struct FullScreenMapView: View {
    @EnvironmentObject var viewModel: HutsViewModel
    let selectedHut: Hut

    var body: some View {
        let selectedHutCoord = CLLocationCoordinate2D(latitude: selectedHut.lat, longitude: selectedHut.lon)
        let initialRegion = MKCoordinateRegion(center: selectedHutCoord, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))

        VStack {
            Map(initialPosition: .region(initialRegion)) {
                ForEach(viewModel.hutsList) { hut in
                    let hutCoord = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
                    Annotation(hut.name, coordinate: hutCoord) {
                        ZStack {
                            if hut.id == selectedHut.id {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.red) // Highlighted color
                                Image(systemName: "house.fill")
                                    .foregroundStyle(Color(UIColor.systemBackground))
                                    .padding(5)
                            } else {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.orange)
                                Image(systemName: "house.fill")
                                    .foregroundStyle(Color(UIColor.systemBackground))
                                    .padding(5)
                            }
                        }
                    }
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .navigationTitle(selectedHut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
