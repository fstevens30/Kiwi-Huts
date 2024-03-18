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
    @EnvironmentObject var user: User
    var hutsList: [Hut]

    var body: some View {
        VStack {
            Text("Completion")
                .font(.title)
                .bold()
            
            Spacer()
            
            CircularProgressView(hutCount: Double(user.completedHuts.count), totalHuts: Double(hutsList.count))
                .frame(width: 200, height: 200)
                .padding()
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy user and hutsList for the preview
        let dummyHut = Hut(id: "1", name: "Hut1", status: "OPEN", region: "Region1", y: 1, x: 1, locationString: nil, numberOfBunks: nil, facilities: nil, hutCategory: "Standard", proximityToRoadEnd: nil, bookable: false, introduction: "Introduction", introductionThumbnail: "Thumbnail", staticLink: "Link", place: nil, lon: 1.0, lat: 1.0)
        let hutsList = [dummyHut, dummyHut, dummyHut, dummyHut, dummyHut]

        CompletionView(hutsList: hutsList)
    }
}
