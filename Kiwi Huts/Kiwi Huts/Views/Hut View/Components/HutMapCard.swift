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
                            .foregroundStyle(Color(UIColor.systemBackground))
                            .padding(5)
                    }
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding(10)
            
            NavigationLink(destination: FullScreenMapView(selectedHut: hut)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color(UIColor.systemBackground))
                        .opacity(0.8)
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .foregroundStyle(Color.gray)
                        .padding(5)
                }
                .frame(width: 50, height: 50)
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
        }
    }
}
