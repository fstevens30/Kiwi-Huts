//
//  NavigationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: HutsViewModel
    @State private var selectedTab = 2
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }
                .tag(1)
            
            HutListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Huts")
                }
                .tag(2)
            
            SavedView()
                .tabItem {
                    Image(systemName: "star.circle.fill")
                    Text("Saved")
                }
                .tag(3)
            
            CompletionView()
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Completion")
                }
                .tag(4)
        }
        
    }
}
