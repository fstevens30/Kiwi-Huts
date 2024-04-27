//
//  NavigationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 2
    let hutsList: [Hut]
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
                }
                .tag(0)
            
            SearchView(huts: hutsList)
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                }
                .tag(1)
            
            HutListView(huts: hutsList)
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
            
            CompletionView(hutsList: hutsList)
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Completion")
                }
                .tag(4)
        }
        
    }
}

#Preview {
    MainTabView(hutsList: [])
}
