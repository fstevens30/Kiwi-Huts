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
    @State private var selectedHut: Hut?
    @State private var selectedHutForNavigation: Hut?
    @State private var isNavigationActive = false
    @State private var initialRegionSet = false

    init(selectedHut: Hut? = nil) {
        _selectedHut = State(initialValue: selectedHut)
    }

    var body: some View {
        VStack {
            MapViewRepresentable(
                huts: $viewModel.hutsList,
                selectedHut: $selectedHut, // Pass binding
                selectedHutForNavigation: $selectedHutForNavigation,
                isNavigationActive: $isNavigationActive,
                initialRegionSet: $initialRegionSet
            )
            .navigationBarTitle("", displayMode: .inline)
            
            if let hut = selectedHutForNavigation {
                NavigationLink(destination: HutView(hut: hut), isActive: $isNavigationActive) {
                    EmptyView()
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var huts: [Hut]
    @Binding var selectedHut: Hut?
    @Binding var selectedHutForNavigation: Hut?
    @Binding var isNavigationActive: Bool
    @Binding var initialRegionSet: Bool

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        if let selectedHut = selectedHut {
            let selectedHutCoord = CLLocationCoordinate2D(latitude: selectedHut.lat, longitude: selectedHut.lon)
            mapView.setRegion(MKCoordinateRegion(center: selectedHutCoord, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)), animated: true)
            context.coordinator.initialRegionSet = true
        } else {
            mapView.setRegion(defaultRegion, animated: true)
        }
        mapView.mapType = .hybrid
        mapView.isPitchEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if !context.coordinator.initialRegionSet {
            if let selectedHut = selectedHut {
                let selectedHutCoord = CLLocationCoordinate2D(latitude: selectedHut.lat, longitude: selectedHut.lon)
                uiView.setRegion(MKCoordinateRegion(center: selectedHutCoord, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)), animated: true)
            } else {
                uiView.setRegion(defaultRegion, animated: true)
            }
            context.coordinator.initialRegionSet = true
        }

        let existingAnnotations = Set(uiView.annotations.compactMap { $0 as? MKPointAnnotation })
        let newAnnotations = Set(huts.map { hut -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
            annotation.title = hut.name
            annotation.subtitle = hut.hutCategory  // Store the category in the subtitle for easy access
            return annotation
        })
        
        let annotationsToRemove = existingAnnotations.subtracting(newAnnotations)
        let annotationsToAdd = newAnnotations.subtracting(existingAnnotations)
        
        uiView.removeAnnotations(Array(annotationsToRemove))
        uiView.addAnnotations(Array(annotationsToAdd))

        if let selectedHut = selectedHut, !context.coordinator.initialRegionSet {
            if let annotation = uiView.annotations.first(where: { ($0 as? MKPointAnnotation)?.title == selectedHut.name }) {
                uiView.selectAnnotation(annotation, animated: true)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -40.9006, longitude: 174.886), span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0))
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable
        var initialRegionSet = false

        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation) as? MKMarkerAnnotationView,
                  let subtitle = annotation.subtitle else {
                return nil
            }

            let isSelected = (annotation.title == parent.selectedHut?.name)
            let markerColor: UIColor = (parent.selectedHut == nil || isSelected) ? UIColor(Color.accentColor) : UIColor(Color.primary)
            
            annotationView.markerTintColor = markerColor
            annotationView.glyphImage = UIImage(systemName: categoryIconName(for: subtitle ?? ""))
            return annotationView
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation as? MKPointAnnotation,
                  let title = annotation.title,
                  let selectedHut = hutMatching(title: title) else {
                return
            }
            parent.selectedHut = selectedHut // Update selectedHut
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
