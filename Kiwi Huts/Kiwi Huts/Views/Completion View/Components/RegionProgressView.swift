//
//  RegionProgressView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 29/04/2024.
//

import SwiftUI

struct RegionProgressView: View {
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 20)
                    .opacity(0.3)
                    .foregroundStyle(Color.accentColor)
                Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 20
                        )
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}


#Preview {
    RegionProgressView()
}
