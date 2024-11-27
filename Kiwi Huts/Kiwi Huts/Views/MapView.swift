//
//  MapView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 10/06/2024.
//

import SwiftUI
import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude &&
        lhs.center.longitude == rhs.center.longitude &&
        lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
        lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
}

extension CLLocationCoordinate2D {
    static let initialNZ: Self = .init(latitude: -40.9006, longitude: 174.8860)
}

let initialRegion = MKCoordinateRegion(
    center: .initialNZ,
    span: MKCoordinateSpan(latitudeDelta: 2.5, longitudeDelta: 2.5)
)

struct MapView: View {
    @EnvironmentObject var viewModel: HutsViewModel
    @State private var region = initialRegion
    @State private var selectedHut: Hut? // Track selected hut
    @State private var isNavigationActive = false // Navigation state

    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true, annotationItems: viewModel.hutsList) { hut in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)) {
                        HutAnnotation(hut: hut)
                            .onTapGesture {
                                selectedHut = hut // Set the selected hut
                                isNavigationActive = true
                            }
                    }
                }
                .mapStyle(.hybrid(elevation: .realistic))
                .onAppear {
                    let locationManager = CLLocationManager()
                    locationManager.requestWhenInUseAuthorization()
                    if let userLocation = locationManager.location?.coordinate {
                        region = MKCoordinateRegion(
                            center: userLocation,
                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        )
                    } else {
                        region = initialRegion
                    }
                }
                NavigationLink(
                    destination: selectedHut.map { HutView(hut: $0) },
                    isActive: $isNavigationActive
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("Map")
        }
    }
}

struct HutAnnotation: View {
    let hut: Hut

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15.0)
                    .foregroundStyle(Color.accentColor)
                Image(systemName: "house.fill")
                    .foregroundColor(.white)
            }
            .frame(width: 30, height: 30) // Adjust size as needed
        }
    }
}

// Helper extension to check if a coordinate is within the region
extension MKCoordinateRegion {
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let latDelta = span.latitudeDelta / 2.0
        let lonDelta = span.longitudeDelta / 2.0

        let northWestCorner = CLLocationCoordinate2D(latitude: center.latitude - latDelta, longitude: center.longitude - lonDelta)
        let southEastCorner = CLLocationCoordinate2D(latitude: center.latitude + latDelta, longitude: center.longitude + lonDelta)

        return coordinate.latitude >= northWestCorner.latitude &&
               coordinate.latitude <= southEastCorner.latitude &&
               coordinate.longitude >= northWestCorner.longitude &&
               coordinate.longitude <= southEastCorner.longitude
    }
}
