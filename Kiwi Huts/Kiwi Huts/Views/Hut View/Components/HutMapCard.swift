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
        let initialRegion = MKCoordinateRegion(center: hutCoord, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))

        ZStack(alignment: .topTrailing) {
            HutMapViewRepresentable(hut: hut, initialRegion: initialRegion)
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

struct HutMapViewRepresentable: UIViewRepresentable {
    let hut: Hut
    let initialRegion: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = initialRegion
        mapView.mapType = .hybrid
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: hut.lat, longitude: hut.lon)
        annotation.title = hut.name
        annotation.subtitle = hut.hutCategory  // Store the category in the subtitle for easy access
        uiView.addAnnotation(annotation)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: HutMapViewRepresentable

        init(_ parent: HutMapViewRepresentable) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation) as? MKMarkerAnnotationView,
                  let subtitle = annotation.subtitle else {
                return nil
            }
            annotationView.markerTintColor = UIColor(Color.accentColor)
            annotationView.glyphImage = UIImage(systemName: categoryIconName(for: subtitle ?? ""))
            return annotationView
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
    }
}
