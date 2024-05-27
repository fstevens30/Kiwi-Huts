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
                    VStack {
                        List(user.savedHuts) { hut in
                            NavigationLink(destination: HutView(hut: hut)) {
                                ListedHutView(hut: hut)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Saved")
        }
    }
}
