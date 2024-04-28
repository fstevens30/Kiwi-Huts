//
//  HutInfoCard.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 28/03/2024.
//

import SwiftUI

struct HutInfoCard: View {
    var imageName: String
    var text: String
    var iconColor: Color = .accentColor
    var bgColor: Color = .gray
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(iconColor)
            Divider()
            Text(text)
                .font(.footnote)
                .bold()
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(bgColor.opacity(0.1)))
            //.fill(Color.bg.opacity(0.1)))
        .padding([.leading, .trailing])
    }
}

#Preview {
    HutInfoCard(imageName: "bed.double.circle.fill", text: "4")
}