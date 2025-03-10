//
//  Model.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 21.12.23.
//

import Foundation
import UIKit

struct JournalEntry: Identifiable {
    // MARK: - Properties
    let id = UUID() // Ensures each entry is uniquely identifiable
    var title: String
    var description: String
    var date: Date
    var images: [UIImage]? // Modified to store an array of images
    
    // MARK: - Initialization
    init(title: String, description: String, date: Date, images: [UIImage]? = nil) {
        self.title = title
        self.description = description
        self.date = date
        self.images = images
    }
}
