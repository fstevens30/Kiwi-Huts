//
//  HutListView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct HutListView: View {
    @EnvironmentObject var viewModel: HutsViewModel

    var body: some View {
        NavigationView {
            List(viewModel.hutsList, id: \.id) { hut in
                NavigationLink(destination: HutView(hut: hut)) {
                    ListedHutView(hut: hut)
                }
            }
            .navigationTitle("Huts")
            .onAppear {
                print("Huts available: \(viewModel.hutsList.count)")
                viewModel.fetchHutsIfNeeded()  // Ensure data is fetched when needed
            }
        }
    }
}
