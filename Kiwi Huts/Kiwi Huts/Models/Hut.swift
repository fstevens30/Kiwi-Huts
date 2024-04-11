//
//  Hut.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import Foundation

struct Hut: Identifiable, Codable {
    var id: String // Use 'id' as the unique identifier (based on id)
    var name: String
    var status: String
    var region: String
    var y: Double
    var x: Double
    var locationString: String?
    var numberOfBunks: Int?
    var facilities: [String]?
    var hutCategory: String
    var proximityToRoadEnd: String?
    var bookable: Bool
    var introduction: String
    var introductionThumbnail: String
    var staticLink: String
    var place: String?
    var lon: Double
    var lat: Double
}
