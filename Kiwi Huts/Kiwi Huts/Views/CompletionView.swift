//
//  CompletionView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
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
        
        
        Text("\(Int(hutCount)) of \(Int(totalHuts)) Huts visited.")
            .bold()
    }
}

struct CompletionView: View {
    
    var body: some View {
        VStack {
            
            Text("Completion")
                .font(.title)
                .bold()
            
            Spacer()
            
            CircularProgressView(hutCount: 240, totalHuts: 550)
                .frame(width: 200, height: 200)
                .padding()
        }
    }
}

#Preview {
    CompletionView()
}
