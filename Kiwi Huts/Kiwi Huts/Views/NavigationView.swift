//
//  NavigationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct NavigationView: View {
    
    @State private var selectedTab = 2
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
                }
                .tag(0)
            
            CompletionView()
                .tabItem {
                    Image(systemName: "checkmark.square.fill")
                    Text("Completion")
                }
                .tag(1)
            
            HutListView()
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
            
            ListsView()
                .tabItem {
                    Image(systemName: "square.stack.fill")
                    Text("Lists")
                }
                .tag(4)
        }
        
    }
}

#Preview {
    NavigationView()
}
