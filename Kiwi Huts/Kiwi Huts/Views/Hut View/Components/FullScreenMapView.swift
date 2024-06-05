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
    @StateObject private var locationManager = LocationManager()
    var selectedHut: Hut?
    @State private var selectedHutForNavigation: Hut?
    @State private var isNavigationActive = false

    var body: some View {
        let initialRegion = getInitialRegion()
        NavigationView {
            VStack {
                MapViewRepresentable(huts: $viewModel.hutsList, initialRegion: initialRegion, selectedHut: selectedHut, selectedHutForNavigation: $selectedHutForNavigation, isNavigationActive: $isNavigationActive)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                
                if let hut = selectedHutForNavigation ?? selectedHut {
                    NavigationLink(destination: HutView(hut: hut), isActive: $isNavigationActive) {
                        EmptyView()
                    }
                }
            }
        }
    }

    private func getInitialRegion() -> MKCoordinateRegion {
        if let selectedHut = selectedHut {
            let selectedHutCoord = CLLocationCoordinate2D(latitude: selectedHut.lat, longitude: selectedHut.lon)
            return MKCoordinateRegion(center: selectedHutCoord, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        } else if let userLocation = locationManager.userLocation {
            return MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        } else {
            let defaultCoord = CLLocationCoordinate2D(latitude: -40.9006, longitude: 174.886) // Coordinates of New Zealand
            return MKCoordinateRegion(center: defaultCoord, span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0))
        }
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var huts: [Hut]
    let initialRegion: MKCoordinateRegion
    var selectedHut: Hut?
    @Binding var selectedHutForNavigation: Hut?
    @Binding var isNavigationActive: Bool

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(initialRegion, animated: true)
        mapView.mapType = .hybrid
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        let annotations = huts.map { hut -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
            annotation.title = hut.name
            annotation.subtitle = hut.hutCategory  // Store the category in the subtitle for easy access
            return annotation
        }
        uiView.addAnnotations(annotations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable

        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation) as? MKMarkerAnnotationView,
                  let subtitle = annotation.subtitle else {
                return nil
            }
            
            annotationView.markerTintColor = (annotation.title == parent.selectedHut?.name) ? UIColor(Color.accentColor) : UIColor(Color.primary)
            annotationView.glyphImage = UIImage(systemName: categoryIconName(for: subtitle ?? ""))
            return annotationView
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation as? MKPointAnnotation,
                  let title = annotation.title,
                  let selectedHut = hutMatching(title: title) else {
                return
            }
            parent.selectedHutForNavigation = selectedHut
            parent.isNavigationActive = true
        }

        private func categoryIconName(for category: String) -> String {
            switch category {
            case "Great Walk":
                return "house.lodge.fill"
            case "Standard", "Serviced":
                return "house.fill"
            case "Basic/bivvies":
                return "tent.fill"
            case "Serviced Alpine":
                return "mountain.2.fill"
            default:
                return "questionmark.diamond.fill"
            }
        }

        func hutMatching(title: String?) -> Hut? {
            guard let title = title else { return nil }
            return parent.huts.first(where: { $0.name == title })
        }
    }
}
