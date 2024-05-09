//
//  ListedHutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 18/03/2024.
//

import SwiftUI

struct ListedHutView: View {
    @EnvironmentObject var user: User
    let hut: Hut

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: hut.introductionThumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 75) // Adjust these values to your preference
                        .clipped()
                }
                else {
                    Image(systemName: "house.fill")
                        .frame(width: 100, height: 75)
                        .clipped()
                }
            }
            .padding()

            VStack(alignment: .leading) {
                Text(hut.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(hut.region ?? "Region Unavailable")
                    .font(.subheadline)
                    .foregroundStyle(Color.accentColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
            }
            Spacer()
        }
        .swipeActions(allowsFullSwipe: false) {
            Button {
                // save the hut to the User.completedHuts list
                user.completedHuts.append(hut)
                user.saveData()
            } label: {
                Label("Complete", systemImage: "checkmark.circle.fill")
            }
            .tint(.green)
            
            Button {
                // save the hut to the User.savedHuts list
                user.savedHuts.append(hut)
                user.saveData()
            } label: {
                Label("Save", systemImage: "star.circle.fill")
            }
            .tint(.yellow)
        }
    }
}
