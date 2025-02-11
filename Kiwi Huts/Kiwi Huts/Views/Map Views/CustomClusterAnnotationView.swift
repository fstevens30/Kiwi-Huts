//
//  CustomClusterAnnotationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 10/12/2024.
//

import Foundation
import MapKit

class CustomClusterAnnotationView: MKAnnotationView {
    static let reuseID = "CustomCluster"
    var accentColor: UIColor = .systemBlue // Default accent color
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let cluster = newValue as? MKClusterAnnotation else { return }

            // Clear existing subviews
            subviews.forEach { $0.removeFromSuperview() }

            // Create a bubble
            let count = cluster.memberAnnotations.count
            let bubbleSize: CGFloat = 50
            let bubbleView = UIView(frame: CGRect(x: 0, y: 0, width: bubbleSize, height: bubbleSize))
            bubbleView.backgroundColor = accentColor // Use the accent color here
            bubbleView.layer.cornerRadius = bubbleSize / 2
            bubbleView.clipsToBounds = true

            // Add the count label
            let countLabel = UILabel(frame: bubbleView.bounds)
            countLabel.text = "+\(count)"
            countLabel.textColor = .white
            countLabel.textAlignment = .center
            countLabel.font = UIFont.boldSystemFont(ofSize: 16)
            bubbleView.addSubview(countLabel)

            // Add the bubble to the annotation view
            addSubview(bubbleView)

            // Adjust the frame of the annotation view
            frame = CGRect(x: 0, y: 0, width: bubbleSize, height: bubbleSize)
            centerOffset = CGPoint(x: 0, y: 0) // Center the bubble directly on the map pin
        }
    }
}
