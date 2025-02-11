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
    @EnvironmentObject var user: User
    let hut: Hut
    
    var body: some View {
        let position = MapCameraPosition.region(MKCoordinateRegion(center: hut.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        
        ZStack {
            Map(initialPosition: position, interactionModes: []) {
                Marker(hut.name, coordinate: hut.coordinate)
            }
            .mapStyle(user.mapType.mapStyle)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(hut.name)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding(10)
        }
    }
}



