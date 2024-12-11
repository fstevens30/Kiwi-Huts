//
//  MapCard.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 03/12/2024.
//

import Foundation
import SwiftUI
import MapKit

struct MapCard: View {
    let hut: Hut
    
    var body: some View {
        let position = MapCameraPosition.region(MKCoordinateRegion(center: hut.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        
        ZStack {
            Map(initialPosition: position, interactionModes: []) {
                Annotation(hut.name, coordinate: hut.coordinate) {
                    HutMarker(hut: hut)
                }
                .annotationTitles(.hidden)
            }
            .mapStyle(.hybrid)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(hut.name)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding(10)
        }
    }
}



