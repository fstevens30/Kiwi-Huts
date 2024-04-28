//
//  HutInfoCardContainer.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 26/04/2024.
//

import SwiftUI

struct HutInfoCardContainer: View {
    let hut: Hut

    var body: some View {
        VStack {
            if let facilities = hut.facilities, !facilities.isEmpty {
                Divider()
                Text("Facilities")
                    .font(.headline)
                    .padding(.vertical)

                // Status of the hut
                HutInfoCard(
                    imageName: hut.status.lowercased() == "open" ? "lock.open.fill" : "lock.fill",
                    text: hut.status,
                    iconColor: hut.status.lowercased() != "open" ? .black : .accentColor,
                    bgColor: hut.status.lowercased() != "open" ? .red : .gray
                    )

                // Number of beds available
                HutInfoCard(imageName: "bed.double.circle.fill", text: "\(hut.numberOfBunks ?? 0) Beds")

                // Category of the hut, determined by the function
                HutInfoCard(imageName: categoryIconName(), text: hut.hutCategory)

                // Display each facility with appropriate icon
                ForEach(facilities, id: \.self) { facility in
                    HutInfoCard(imageName: iconForFacility(facility), text: facility)
                }
            } else {
                Text("No facilities listed")
                    .padding()
            }
        }
        .padding()
    }

    // Function to determine the icon based on hut category
    private func categoryIconName() -> String {
        switch hut.hutCategory {
        case "Great Walk":
            return "house.lodge.fill"
        case "Standard":
            return "house.fill"
        case "Basic/bivvies":
            return "tent.fill"
        case "Serviced Alpine":
            return "mountain.2.fill"
        default:
            return "house"
        }
    }

    // Function to determine the icon for each facility
    private func iconForFacility(_ facility: String) -> String {
        switch facility.lowercased() {
        case "toilets - non-flush":
            return "toilet.fill"
        case "water":
            return "spigot.fill"
        case "water from stream":
            return "drop.circle.fill"
        case "heating":
            return "fireplace.fill"
        case "lighting":
            return "lightbulb.max.fill"
        case "mattresses":
            return "bed.double.fill"
        default:
            return "questionmark.diamond.fill"
        }
    }
}
