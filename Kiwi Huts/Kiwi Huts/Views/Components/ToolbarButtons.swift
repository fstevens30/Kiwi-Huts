//
//  HutInfoCard.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 26/04/2024.
//

import SwiftUI

struct ToolbarButtons: View {
    @EnvironmentObject var user: User
    let hut: Hut
    
    var body: some View {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    if isHutSaved() {
                        if let index = user.savedHuts.firstIndex(where: { $0.id == hut.id }) {
                                // If found, remove the hut from the saved list
                                user.savedHuts.remove(at: index)
                            } else {
                                user.savedHuts.append(hut)
                                user.saveData()
                            }
                    } else {
                        user.savedHuts.append(hut)
                        user.saveData()
                    }
                }) {
                    Image(systemName: isHutSaved() ? "star.circle.fill" : "star.circle")
                }
                
                Button(action: {
                    if isHutComplete() {
                        if let index = user.completedHuts.firstIndex(where: { $0.id == hut.id }) {
                                // If found, remove the hut from the completed list
                                user.completedHuts.remove(at: index)
                            } else {
                                user.completedHuts.append(hut)
                                user.saveData()
                            }
                    } else {
                        user.completedHuts.append(hut)
                        user.saveData()
                    }
                }) {
                    Image(systemName: isHutComplete() ? "checkmark.circle.fill" : "checkmark.circle")
                }
            }
    }
}