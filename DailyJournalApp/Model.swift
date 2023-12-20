//
//  Model.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 21.12.23.
//

import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
}
