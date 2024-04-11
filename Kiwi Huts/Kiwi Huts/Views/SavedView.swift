//
//  ListsView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var user: User

    var body: some View {
        NavigationView {
            VStack {
                
                if user.savedHuts.isEmpty {
                    VStack {
                        Text("No huts are saved!")
                            .padding()
                        Text("Use the")
                        Text(Image(systemName: "star.circle"))
                            .font(.title)
                            .foregroundStyle(Color.accentColor)
                        Text("button to save huts here.")
                    }
                } else {
                    List(user.savedHuts) { hut in
                        NavigationLink(destination: HutView(hut: hut)) {
                            ListedHutView(hut: hut)
                        }
                    }
                    .padding(.top)
                    .edgesIgnoringSafeArea(.all)
                }
            }
            .navigationTitle("Saved")
        }
    }
}


struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy user and hutsList for the preview
        let dummyHut = Hut(id: "1", name: "Hut1", status: "OPEN", region: "Region1", y: 1, x: 1, locationString: nil, numberOfBunks: nil, facilities: nil, hutCategory: "Standard", proximityToRoadEnd: nil, bookable: false, introduction: "Introduction", introductionThumbnail: "Thumbnail", staticLink: "Link", place: nil, lon: 1.0, lat: 1.0)
        let hutsList = [dummyHut, dummyHut, dummyHut, dummyHut, dummyHut]

        SavedView()
            .environmentObject(User(completedHuts: [dummyHut, dummyHut, dummyHut], savedHuts: [dummyHut, dummyHut, dummyHut]))
    }
}

