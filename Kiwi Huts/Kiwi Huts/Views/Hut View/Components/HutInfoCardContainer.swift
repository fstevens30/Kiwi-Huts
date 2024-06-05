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
                let isOpen = hut.status.lowercased() == "open"
                HutInfoCard(
                    imageName: isOpen ? "lock.open.fill" : "lock.fill",
                    text: isOpen ? "Open" : "Closed",
                    iconColor: isOpen ? .accentColor : .primary,
                    bgColor: isOpen ? .gray : .red
                )

                // Number of beds available
                if let numberOfBunks = hut.numberOfBunks {
                    HutInfoCard(imageName: "bed.double.circle.fill", text: "\(numberOfBunks) Beds")
                }

                // Category of the hut
                if let category = hut.hutCategory {
                    HutInfoCard(imageName: categoryIconName(for: category), text: category)
                }

                // Display each facility with appropriate icon
                ForEach(facilities, id: \.self) { facility in
                    HutInfoCard(imageName: iconForFacility(facility), text: facility)
                }
            } else {
                Text("No facilities listed")
                    .padding()
            }
        }
    }

    // Function to determine the icon based on hut category
    private func categoryIconName(for category: String) -> String {
        switch category {
        case "Great Walk":
            return "house.lodge.fill"
        case "Standard":
            return "house.fill"
        case "Basic/bivvies":
            return "tent.fill"
        case "Serviced Alpine":
            return "mountain.2.fill"
        default:
            return "questionmark.diamond.fill"
        }
    }

    // Function to determine the icon for each facility
    private func iconForFacility(_ facility: String) -> String {
        switch facility.lowercased() {
        case "toilets - flush", "toilets - non-flush":
            return "toilet.fill"
        case "water from tap - not treated, boil before use":
            return "spigot.fill"
        case "water from stream":
            return "water.waves"
        case "water supply":
            return "waterbottle.fill"
        case "heating":
            return "fireplace.fill"
        case "lighting":
            return "lightbulb.max.fill"
        case "mattresses":
            return "bed.double.fill"
        case "cooking":
            return "frying.pan.fill"
        default:
            return "questionmark.diamond.fill"
        }
    }
}
