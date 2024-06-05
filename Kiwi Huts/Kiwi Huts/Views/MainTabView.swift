//
//  NavigationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: HutsViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var selectedTab = UserDefaults.standard.integer(forKey: "lastTab") // For state restoration

    var body: some View {
        TabView(selection: $selectedTab) {
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                .tag(0)
                .environmentObject(viewModel)
            
            FullScreenMapView(selectedHut: nil)
                .tabItem {
                    Label("Map", systemImage: "map.circle.fill")
                }
                .tag(1)
                .environmentObject(viewModel)
            
            HutListView()
                .tabItem {
                    Label("Huts", systemImage: "house.fill")
                }
                .tag(2)
                .environmentObject(viewModel)
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "star.circle.fill")
                }
                .tag(3)
                .environmentObject(viewModel)
            
            CompletionView()
                .tabItem {
                    Label("Completion", systemImage: "checkmark.circle.fill")
                }
                .tag(4)
                .environmentObject(viewModel)
        }
        .onAppear {
            selectedTab = UserDefaults.standard.integer(forKey: "lastTab") // Restore last selected tab
        }
        .onChange(of: selectedTab) {
            saveTab()
        }
        .alert("Limited Functionality", isPresented: .constant(!networkMonitor.isConnected)) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You are not connected to the internet. Some functionality will be limited.")
        }
    }

    private func saveTab() {
        UserDefaults.standard.set(selectedTab, forKey: "lastTab")
    }
}
