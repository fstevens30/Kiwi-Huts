//
//  MKMapViewWrapper.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 09/12/2024.
//

import UIKit
import SwiftUI
import MapKit

struct MKMapViewWrapper: UIViewRepresentable {
    @EnvironmentObject var user: User
    @Binding var huts: [Hut]
    @Binding var selectedHut: Hut?
    @Binding var mapType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.register(HutAnnotationView.self, forAnnotationViewWithReuseIdentifier: HutAnnotationView.reuseID)
        mapView.register(CustomClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomClusterAnnotationView.reuseID)
        mapView.mapType = mapType
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapType
        mapView.removeAnnotations(mapView.annotations)
        let hutAnnotations = huts.map { HutAnnotation(hut: $0) }
        mapView.addAnnotations(hutAnnotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MKMapViewWrapper
        
        init(_ parent: MKMapViewWrapper) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKClusterAnnotation {
                let clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomClusterAnnotationView.reuseID, for: annotation) as! CustomClusterAnnotationView
                clusterView.accentColor = parent.user.accentColor.assetName.toUIColor()
                return clusterView
            }
            
            if annotation is HutAnnotation {
                let hutView = mapView.dequeueReusableAnnotationView(withIdentifier: HutAnnotationView.reuseID, for: annotation) as! HutAnnotationView
                hutView.accentColor = parent.user.accentColor.assetName.toUIColor()
                hutView.clusteringIdentifier = "hutCluster"
                return hutView
            }
            
            return nil
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let hutAnnotation = view.annotation as? HutAnnotation else { return }
            parent.selectedHut = hutAnnotation.hut
            
        }
    }
}

extension String {
    func toUIColor() -> UIColor {
        return UIColor(named: self) ?? .systemBlue
    }
}
