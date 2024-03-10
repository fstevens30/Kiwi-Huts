//
//  HutListView.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 7/03/24.
//

import SwiftUI

struct HutListView: View {
    var huts: [Hut]
    
    var body: some View {
        
        VStack {
            List(huts) { hut in
                
                NavigationLink(destination: HutView(hut: hut)) {
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: hut.thumbnailURL))
                            
                            VStack {
                                Text(hut.name)
                                    .font(.headline)
                                    .foregroundStyle(Color.primary)
                                Text(hut.region ?? "N/A")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.accentColor)
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HutListView_Previews: PreviewProvider {
    static var previews: some View {
        let testHutList = [
            Hut(assetID: "12345678",
                bookable: false,
                hutCategory: "Basic/Bivvies",
                introduction: "This is a test hut",
                thumbnailURL: "https://www.nzherald.co.nz/indepth/news/new-zealand-s-14-best-doc-huts/assets/upBnaQV5Cb/24586239111_21ae70eb13_o-2560x1920.jpeg",
                lat: -46.0,
                lon: 169.0,
                name: "Test Hut",
                staticLink: "google.com",
                status: "OPEN",
                x: 1187178,
                y: 9832123),
            
            Hut(
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
        ]
        
        HutListView(huts: testHutList)
    }
}
