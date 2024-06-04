//
//  HutListView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct HutListView: View {
    @EnvironmentObject var viewModel: HutsViewModel
    @State private var showToast = false
    @State private var toastMessage = ""

    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.hutsList, id: \.id) { hut in
                    NavigationLink(destination: HutView(hut: hut)) {
                        ListedHutView(hut: hut, showToast: $showToast, toastMessage: $toastMessage)
                    }
                }
                .shadow(radius: 5)
                .navigationTitle("Huts")
                .onAppear {
                    print("Huts available: \(viewModel.hutsList.count)")
                }
            }
            
            VStack {
                Spacer()
                if showToast {
                    Toast(message: toastMessage)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                        }
                }
            }
        }
    }
}
