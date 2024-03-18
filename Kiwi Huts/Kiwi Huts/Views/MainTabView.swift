//
//  NavigationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 2
    let user: User
    let hutsList: [Hut]
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
                }
                .tag(0)
            
            CompletionView(hutsList: hutsList)
                .tabItem {
                    Image(systemName: "checkmark.square.fill")
                    Text("Completion")
                }
                .tag(1)
            
            HutListView(huts: hutsList)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Huts")
                }
                .tag(2)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(3)
            
            SavedView()
                .tabItem {
                    Image(systemName: "square.stack.fill")
                    Text("Saved")
                }
                .tag(4)
        }
        
    }
}

#Preview {
    MainTabView(user: User(completedHuts: [], savedHuts: []), hutsList: [])
}
