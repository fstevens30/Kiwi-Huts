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
        VStack {
            NavigationView {
                
                List(user.savedHuts) { hut in
                    NavigationLink(destination: HutView(hut: hut)) {
                        HStack {
                            VStack {
                                Text(hut.name)
                                Text(hut.region)
                            }
                        }
                    }
                }
                .padding(.top)
                .edgesIgnoringSafeArea(.all)
            }
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

