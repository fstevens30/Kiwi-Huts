//
//  CircularProgressView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 29/04/2024.
//

import SwiftUI

struct CircularProgressView: View {
    @EnvironmentObject var user: User
    
    let hutCount: Double
    let totalHuts: Double
    
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(
                    Color(user.accentColor.assetName),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: hutCount / totalHuts)
                .stroke(
                    Color(user.accentColor.assetName),
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .foregroundStyle(Color.primary)
            
            Text("\(Int(hutCount)) / \(Int(totalHuts)) \nHuts")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.primary)
        }
    }
}

#Preview {
    CircularProgressView(hutCount: 22.0, totalHuts: 45.0)
}
