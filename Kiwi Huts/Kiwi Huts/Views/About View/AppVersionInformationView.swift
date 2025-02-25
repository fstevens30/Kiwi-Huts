//
//  AppVersionInformationView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 28/11/2024.
//

import Foundation
import SwiftUI

struct AppVersionInformationView: View {

    let versionString: String
    let appIcon: String

    var body: some View {

        VStack(alignment: .center, spacing: 12) {

            // App icons can only be retrieved as named `UIImage`s
            // https://stackoverflow.com/a/62064533/17421764
            if let image = UIImage(named: appIcon) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 100, height: 100)
                    .shadow(radius: 5)
            }

            VStack(alignment: .center) {
                Text("v\(versionString)")
            }
            .font(.caption)
            .foregroundColor(.primary)
        }

        .fixedSize()

        .accessibilityElement(children: .ignore)
        .accessibilityLabel("App version \(versionString)")
    }
}
