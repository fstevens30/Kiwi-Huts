//
//  ProfileView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 13/12/2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: User
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width:50, height:50)
                        Text("Guest User")
                            .font(.headline)
                    }
                    Divider()
                    HStack {
                        Image(systemName: "house.fill")
                        Text("\(user.completedHuts.count)")
                    }
                }
                
                Spacer()
                
                List {
                    NavigationLink(destination: CompletionView()) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Completed Huts")
                        }
                    }
                    NavigationLink(destination: SavedView()){
                        HStack {
                            Image(systemName: "star.circle.fill")
                            Text("Saved Huts")
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}
