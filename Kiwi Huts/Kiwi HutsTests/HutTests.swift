//
//  HutTests.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 09/05/2024.
//

import XCTest
@testable import Kiwi_Huts

class HutTests: XCTestCase {
    
    func testHutInitialization() {
        let hut = Hut(
            id: "100033374",
            name: "Luxmore Hut",
            status: "OPEN",
            region: "Fiordland",
            y: 4960153,
            x: 1178767,
            locationString: "Fiordland National Park",
            numberOfBunks: 54,
            facilities: [
                "Cooking",
                "Heating",
                "Mattresses",
                "Lighting",
                "Toilets - flush",
                "Water from tap - not treated, boil before use",
                "Water supply"
            ],
            hutCategory: "Great Walk",
            proximityToRoadEnd: nil,
            bookable: true,
            introduction: "This is a 54 bunk, Great Walk hut on the Kepler Track, Fiordland. Bookings required in the Great Walks season.",
            introductionThumbnail: "https://www.doc.govt.nz/thumbs/large/link/262b915193334eaba5bd07f74999b664.jpg",
            staticLink: "https://www.doc.govt.nz/link/dc756fa57891438b8f3fa03813fb7260.aspx",
            place: "Fiordland National Park",
            lon: 167.619159,
            lat: -45.385232
        )
        
        XCTAssertEqual(hut.id, "100033374")
        XCTAssertEqual(hut.name, "Luxmore Hut")
        XCTAssertEqual(hut.status, "OPEN")
        XCTAssertEqual(hut.region, "Fiordland")
        XCTAssertEqual(hut.y, 4960153)
        XCTAssertEqual(hut.x, 1178767)
        XCTAssertEqual(hut.locationString, "Fiordland National Park")
        XCTAssertEqual(hut.numberOfBunks, 54)
        XCTAssertEqual(hut.facilities!, [
            "Cooking",
            "Heating",
            "Mattresses",
            "Lighting",
            "Toilets - flush",
            "Water from tap - not treated, boil before use",
            "Water supply"
        ])
        XCTAssertEqual(hut.hutCategory, "Great Walk")
        XCTAssertEqual(hut.proximityToRoadEnd, nil)
        XCTAssertTrue(hut.bookable)
        XCTAssertEqual(hut.introduction, "This is a 54 bunk, Great Walk hut on the Kepler Track, Fiordland. Bookings required in the Great Walks season.")
        XCTAssertEqual(hut.introductionThumbnail, "https://www.doc.govt.nz/thumbs/large/link/262b915193334eaba5bd07f74999b664.jpg")
        XCTAssertEqual(hut.staticLink, "https://www.doc.govt.nz/link/dc756fa57891438b8f3fa03813fb7260.aspx")
        XCTAssertEqual(hut.place, "Fiordland National Park")
        XCTAssertEqual(hut.lon, 167.619159)
        XCTAssertEqual(hut.lat, -45.385232)
    }
    
    func testHutEncoding() {
        let hut = Hut(id: "002",
                      name: "Riverside Hut",
                      status: "Closed",
                      region: "Westland",
                      y: 543.21,
                      x: 65.43,
                      locationString: nil,
                      numberOfBunks: nil,
                      facilities: nil,
                      hutCategory: "Standard",
                      proximityToRoadEnd: nil,
                      bookable: false,
                      introduction: "A closed hut by the river",
                      introductionThumbnail: "http://example.com/riverside.jpg",
                      staticLink: "http://example.com/riversideinfo",
                      place: nil,
                      lon: 171.0000,
                      lat: -42.0000)

        let encoder = JSONEncoder()
        var encodedData = Data()
        do {
            encodedData = try encoder.encode(hut)
        } catch {
            XCTFail("Encoding failed: \(error)")
        }
        
        let decoder = JSONDecoder()
        var decodedHut: Hut?
        do {
            decodedHut = try decoder.decode(Hut.self, from: encodedData)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
        
        XCTAssertEqual(decodedHut?.id, hut.id)
        XCTAssertEqual(decodedHut?.name, hut.name)
    }
}
