//
//  Item.swift
//  DE213-Project
//
//  Created by Flynn Stevens on 1/03/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
