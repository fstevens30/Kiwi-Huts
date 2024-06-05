//
//  Toast.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 04/06/2024.
//

import SwiftUI

struct Toast: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.subheadline)
            .padding()
            .background(Color(.systemBackground))
            .foregroundColor(Color(.systemGray))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.bottom, 20)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.easeInOut, value: UUID())
    }
}
