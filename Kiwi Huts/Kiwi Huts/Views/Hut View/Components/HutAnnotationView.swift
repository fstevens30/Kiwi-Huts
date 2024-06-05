//
//  HutAnnotationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 04/06/2024.
//

import SwiftUI

struct HutAnnotationView: View {
    let hut: Hut
    let isSelected: Bool

    var body: some View {
        ZStack {
            if isSelected {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.accentColor)
                Image(systemName: "house.fill")
                    .foregroundStyle(Color(UIColor.systemBackground))
                    .padding(5)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(.systemBackground))
                Image(systemName: "house.fill")
                    .foregroundStyle(Color(UIColor.systemFill))
                    .padding(5)
            }
        }
    }
}
