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
    let id = UUID()
    var title: String
    var description: String
    var date: Date
    var image: UIImage? 
    
    // MARK: - Initialization
    init(title: String, description: String, date: Date, image: UIImage? = nil) {
        self.title = title
        self.description = description
        self.date = date
        self.image = image
    }
}
