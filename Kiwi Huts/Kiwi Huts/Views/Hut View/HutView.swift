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
                VStack {
                    AsyncImage(url: URL(string: hut.introductionThumbnail)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 200)
                        } else if phase.error != nil {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200)
                        } else {
                            ProgressView()
                        }
                    }
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .padding()
                        .shadow(radius: 20)
                
                
                    VStack {
                        Text(hut.introduction ?? "No introduction available, please visit DOC website for more information.")
                        
                        if hut.bookable! {
                            Link("Book Now", destination: URL(string: hut.staticLink)!)
                                .buttonStyle(.bordered)
                                .padding()
                        }
                    }
                    .padding()
                }
                
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
