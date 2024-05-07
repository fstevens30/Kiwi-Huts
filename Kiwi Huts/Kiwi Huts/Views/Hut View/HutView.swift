//
//  HutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import SwiftUI

struct HutView: View {
    @EnvironmentObject var user: User
    let hut: Hut

    var body: some View {

        ScrollView {
            VStack {
                AsyncImage(url: URL(string: hut.introductionThumbnail)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable() // Make sure the image can be resized
                                    .aspectRatio(contentMode: .fill) // Maintain the aspect ratio and fill the frame
                                    .frame(maxWidth: .infinity) // Set the image frame to the maximum available width
                                    .clipped() // Clip the overflowing parts of the image
                            } else if phase.error != nil {
                                Color.red // Error state
                            } else {
                                ProgressView() // Loading state
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 25.0)) // Apply corner radius
                        .padding() // Apply padding around the image
                
                
                VStack {
                    Text(hut.introduction ?? "No introduction available, please visit DOC website for more information.")
                    
                    if hut.bookable! {
                        Link("Book Now", destination: URL(string: hut.staticLink)!)
                            .buttonStyle(.bordered)
                            .padding()
                    }
                }
                .padding()
                
                Spacer()
                
                HutInfoCardContainer(hut: hut)
                
                Spacer()
                
                
                HutMapCard(hut: hut)
                
            }
        }
        .navigationTitle(hut.name)
        .toolbar {
            ToolbarButtons(hut: hut)
        }
    }
}

