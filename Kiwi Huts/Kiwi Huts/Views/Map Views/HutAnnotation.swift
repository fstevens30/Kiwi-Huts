//
//  HutAnnotation.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 10/12/2024.
//

import MapKit
import SwiftUI

class HutAnnotation: NSObject, MKAnnotation {
    let hut: Hut
    
    var coordinate: CLLocationCoordinate2D {
        return hut.coordinate
    }
    
    var iconName: String {
        return hut.iconName
    }
    
    var hutName: String {
        return hut.name
    }
    
    init(hut: Hut) {
        self.hut = hut
    }
}

class HutAnnotationView: MKAnnotationView {
    @EnvironmentObject var user: User
    static let reuseID = "HutAnnotation"
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let hutAnnotation = newValue as? HutAnnotation else { return }
            
            // Create a marker view
            let markerSize: CGFloat = 50
            let markerView = UIView(frame: CGRect(x: 0, y: 0, width: markerSize, height: markerSize))
            markerView.backgroundColor = .black
            markerView.layer.cornerRadius = 15
            markerView.clipsToBounds = true
            
            // Add the hut icon
            let hutImage = UIImageView(frame: markerView.bounds)
            hutImage.image = UIImage(systemName: hutAnnotation.iconName)
            hutImage.tintColor = .white
            hutImage.contentMode = .center
            markerView.addSubview(hutImage)
            
            // Create a container view
            let containerView = UIView()
            
            // Add the marker to the container view
            containerView.addSubview(markerView)
            
            // Add the hut name label
            let nameLabel = UILabel()
            nameLabel.text = hutAnnotation.hutName
            nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            nameLabel.textColor = .systemBackground
            nameLabel.textAlignment = .center
            nameLabel.numberOfLines = 0 // Allow multiple lines if needed
            
            // Calculate the size needed for the label
            let maxLabelWidth: CGFloat = 150 // Maximum width for the label
            let labelSize = nameLabel.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
            nameLabel.frame = CGRect(x: 0, y: markerSize, width: labelSize.width, height: labelSize.height)
            
            // Adjust containerView's frame to fit marker and label
            let containerHeight = markerSize + labelSize.height
            let containerWidth = max(markerSize, labelSize.width)
            containerView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
            
            // Center the marker and label within the container
            markerView.center = CGPoint(x: containerWidth / 2, y: markerSize / 2)
            nameLabel.center = CGPoint(x: containerWidth / 2, y: markerSize + labelSize.height / 2)
            
            // Add the label to the container
            containerView.addSubview(nameLabel)
            
            // Remove old subviews if any
            self.subviews.forEach { $0.removeFromSuperview() }
            
            // Add the container view to the annotation view
            self.addSubview(containerView)
            
            // Set the frame of the annotation view
            frame = containerView.frame
            
            // Adjust centerOffset to ensure the annotation is correctly positioned
            self.centerOffset = CGPoint(x: 0, y: -markerSize / 2)
        }
    }
}
