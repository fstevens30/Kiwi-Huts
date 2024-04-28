//
//  CircularProgressView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 29/04/2024.
//

import SwiftUI

struct CircularProgressView: View {
    
    let hutCount: Double
    let totalHuts: Double
    
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(
                    Color.accentColor.opacity(0.5),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: hutCount / totalHuts)
                .stroke(
                    Color.accentColor,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

#Preview {
    CircularProgressView(hutCount: 22.0, totalHuts: 45.0)
}
