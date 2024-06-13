//
//  HutTests.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 09/05/2024.
//

import XCTest
import Firebase
@testable import Kiwi_Huts

class HutTests: XCTestCase {
    
    func testHutInitialization() {
        let hut = Hut(
            id: "1",
            name: "Sample Hut",
            status: "Open",
            region: "Otago",
            locationString: "Somewhere",
            numberOfBunks: 10,
            facilities: ["Heating", "Water"],
            hutCategory: "Serviced",
            proximityToRoadEnd: "Close",
            bookable: true,
            introduction: "A beautiful hut in Otago",
            introductionThumbnail: "https://example.com/thumbnail.jpg",
            staticLink: "https://example.com/staticlink",
            place: "Otago",
            lon: 170.0,
            lat: -45.0
        )
        
        XCTAssertEqual(hut.id, "1")
        XCTAssertEqual(hut.name, "Sample Hut")
        XCTAssertEqual(hut.status, "Open")
        XCTAssertEqual(hut.region, "Otago")
        XCTAssertEqual(hut.locationString, "Somewhere")
        XCTAssertEqual(hut.numberOfBunks, 10)
        XCTAssertEqual(hut.facilities, ["Heating", "Water"])
        XCTAssertEqual(hut.hutCategory, "Serviced")
        XCTAssertEqual(hut.proximityToRoadEnd, "Close")
        XCTAssertEqual(hut.bookable, true)
        XCTAssertEqual(hut.introduction, "A beautiful hut in Otago")
        XCTAssertEqual(hut.introductionThumbnail, "https://example.com/thumbnail.jpg")
        XCTAssertEqual(hut.staticLink, "https://example.com/staticlink")
        XCTAssertEqual(hut.place, "Otago")
        XCTAssertEqual(hut.lon, 170.0)
        XCTAssertEqual(hut.lat, -45.0)
    }

    func testHutDecoding() throws {
        let json = """
        {
            "id": 1,
            "name": "Sample Hut",
            "status": "Open",
            "region": "Otago",
            "locationString": "Somewhere",
            "numberOfBunks": 10,
            "facilities": ["Heating", "Water"],
            "hutCategory": "Serviced",
            "proximityToRoadEnd": "Close",
            "bookable": true,
            "introduction": "A beautiful hut in Otago",
            "introductionThumbnail": "https://example.com/thumbnail.jpg",
            "staticLink": "https://example.com/staticlink",
            "place": "Otago",
            "lon": 170.0,
            "lat": -45.0
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let hut = try decoder.decode(Hut.self, from: json)
        
        XCTAssertEqual(hut.id, "1")
        XCTAssertEqual(hut.name, "Sample Hut")
        XCTAssertEqual(hut.status, "Open")
        XCTAssertEqual(hut.region, "Otago")
        XCTAssertEqual(hut.locationString, "Somewhere")
        XCTAssertEqual(hut.numberOfBunks, 10)
        XCTAssertEqual(hut.facilities, ["Heating", "Water"])
        XCTAssertEqual(hut.hutCategory, "Serviced")
        XCTAssertEqual(hut.proximityToRoadEnd, "Close")
        XCTAssertEqual(hut.bookable, true)
        XCTAssertEqual(hut.introduction, "A beautiful hut in Otago")
        XCTAssertEqual(hut.introductionThumbnail, "https://example.com/thumbnail.jpg")
        XCTAssertEqual(hut.staticLink, "https://example.com/staticlink")
        XCTAssertEqual(hut.place, "Otago")
        XCTAssertEqual(hut.lon, 170.0)
        XCTAssertEqual(hut.lat, -45.0)
    }
    
    func testHutDecodingWithMissingFields() throws {
        let json = """
        {
            "id": 2,
            "name": "Another Hut",
            "status": "Closed",
            "lon": 160.0,
            "lat": -40.0
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let hut = try decoder.decode(Hut.self, from: json)
        
        XCTAssertEqual(hut.id, "2")
        XCTAssertEqual(hut.name, "Another Hut")
        XCTAssertEqual(hut.status, "Closed")
        XCTAssertEqual(hut.region, "Other") // Default value
        XCTAssertNil(hut.locationString)
        XCTAssertNil(hut.numberOfBunks)
        XCTAssertNil(hut.facilities)
        XCTAssertEqual(hut.hutCategory, "N/A") // Default value
        XCTAssertNil(hut.proximityToRoadEnd)
        XCTAssertEqual(hut.bookable, false) // Default value
        XCTAssertNil(hut.introduction)
        XCTAssertEqual(hut.introductionThumbnail, "https://www.doc.govt.nz/images/no-photo/no-photo-220x140.jpg") // Default value
        XCTAssertEqual(hut.staticLink, "https://www.doc.govt.nz/parks-and-recreation/places-to-stay/stay-in-a-hut/") // Default value
        XCTAssertNil(hut.place)
        XCTAssertEqual(hut.lon, 160.0)
        XCTAssertEqual(hut.lat, -40.0)
    }
}
