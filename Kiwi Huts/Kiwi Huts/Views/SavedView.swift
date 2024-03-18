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


#Preview {
    SavedView()
}
