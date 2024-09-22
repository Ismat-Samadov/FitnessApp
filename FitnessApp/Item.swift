//
//  Item.swift
//  FitnessApp
//
//  Created by Ismat Samadov on 22.09.24.
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
