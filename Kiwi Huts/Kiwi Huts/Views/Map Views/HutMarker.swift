//
//  MapMarker.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 03/12/2024.
//

import SwiftUI
import MapKit

struct HutMarker: View {
    var hut: Hut
    @State private var isActive = false

    var body: some View {
        VStack {
            Button(action: {
                isActive = true
            }) {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.accentColor)
                        Image(systemName: hut.iconName)
                            .foregroundColor(.white)
                    }
                    Text(hut.name)
                        .font(.caption)
                        .foregroundColor(.white)
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
        }
    }
}
