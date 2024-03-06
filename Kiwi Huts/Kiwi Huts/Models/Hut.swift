//
//  Hut.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

class Hut: Identifiable {
    
    var assetID: String
    var bookable: Bool
    var facilities: [String]?
    var hutCategory: String
    var introduction: String
    var thumbnailURL: String
    var lat: Double
    var locationString: String?
    var lon: Double
    var name: String
    var numberOfBunks: Int?
    var place: String?
    var proximityToRoadEnd: String?
    var region: String?
    var staticLink: String
    var status: String
    var x: Int
    var y: Int
    
    init(assetID: String, bookable: Bool, facilities: [String]? = nil, hutCategory: String, introduction: String, thumbnailURL: String, lat: Double, locationString: String? = nil, lon: Double, name: String, numberOfBunks: Int? = nil, place: String? = nil, proximityToRoadEnd: String? = nil, region: String? = nil, staticLink: String, status: String, x: Int, y: Int) {
        self.assetID = assetID
        self.bookable = bookable
        self.facilities = facilities
        self.hutCategory = hutCategory
        self.introduction = introduction
        self.thumbnailURL = thumbnailURL
        self.lat = lat
        self.locationString = locationString
        self.lon = lon
        self.name = name
        self.numberOfBunks = numberOfBunks
        self.place = place
        self.proximityToRoadEnd = proximityToRoadEnd
        self.region = region
        self.staticLink = staticLink
        self.status = status
        self.x = x
        self.y = y
    }
}
