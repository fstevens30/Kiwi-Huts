//
//  HutView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import SwiftUI

struct HutView: View {
    let hut: Hut
    
    var body: some View {
        VStack {
            Text(hut.name)
            
        }
    }
}

#Preview {
    
    var testHut = Hut(
        assetID: "100033374",
        bookable: true,
        hutCategory: "Great Walk",
        introduction: "This is a 54 bunk, Great Walk hut on the Kepler Track, Fiordland. Bookings required in the Great Walks season. ",
        thumbnailURL: "https://www.doc.govt.nz/thumbs/large/link/5c957abd98084ead9568ffeb51696c65.jpg",
        lat: -45.385232,
        lon: 167.619159,
        name: "Luxmore Hut",
        staticLink: "https://www.doc.govt.nz/link/dc756fa57891438b8f3fa03813fb7260.aspx",
        status: "OPEN",
        x: 1178767,
        y: 4960153
        )
    
    HutView(hut: testHut)
}
