//
//  Hut.swift
//  Kiwi Huts
//
//  Created by Flynn Stevens on 6/03/24.
//

import Foundation

struct Hut: Identifiable, Codable {
    var id: String
    var name: String
    var status: String
    var region: String?
    var locationString: String?
    var numberOfBunks: Int?
    var facilities: [String]?
    var hutCategory: String?
    var proximityToRoadEnd: String?
    var bookable: Bool?
    var introduction: String?
    var introductionThumbnail: String
    var staticLink: String
    var place: String?
    var lon: Double
    var lat: Double
    
    
    // Custom initializer for decoding
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
                    if let idString = try? container.decode(String.self, forKey: .id) {
                        id = idString
                    } else if let idInt = try? container.decode(Int.self, forKey: .id) {
                        id = String(idInt)
                    } else {
                        throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "ID is neither a string nor an integer")
                    }
            name = try container.decode(String.self, forKey: .name)
            status = try container.decode(String.self, forKey: .status)
            region = try container.decodeIfPresent(String.self, forKey: .region) ?? "Other"
            locationString = try container.decodeIfPresent(String.self, forKey: .locationString)
            numberOfBunks = try container.decodeIfPresent(Int.self, forKey: .numberOfBunks)
            facilities = try container.decodeIfPresent([String].self, forKey: .facilities)
            hutCategory = try container.decodeIfPresent(String.self, forKey: .hutCategory) ?? "N/A"
            proximityToRoadEnd = try container.decodeIfPresent(String.self, forKey: .proximityToRoadEnd)
            bookable = try container.decodeIfPresent(Bool.self, forKey: .bookable) ?? false
            introduction = try container.decodeIfPresent(String.self, forKey: .introduction)
            introductionThumbnail = try container.decodeIfPresent(String.self, forKey: .introductionThumbnail) ?? "https://www.doc.govt.nz/images/no-photo/no-photo-220x140.jpg"
            staticLink = try container.decodeIfPresent(String.self, forKey: .staticLink) ?? "https://www.doc.govt.nz/parks-and-recreation/places-to-stay/stay-in-a-hut/"
            place = try container.decodeIfPresent(String.self, forKey: .place)
            lon = try container.decode(Double.self, forKey: .lon)
            lat = try container.decode(Double.self, forKey: .lat)
        }
    }
