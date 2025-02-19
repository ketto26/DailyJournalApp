//
//  Meneger.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 21.12.23.
//

import Foundation
import UIKit

class NewsManager: ObservableObject {
    // MARK: - Properties
    @Published var journalEntries: [JournalEntry] = []
    
    
    // MARK: - Functions
    func addEntry(title: String, description: String, date: Date, image: UIImage?) {
        let newEntry = JournalEntry(title: title, description: description, date: date, image: image)
        journalEntries.insert(newEntry, at: 0)
    }
    
    func deleteEntry(at indexSet: IndexSet) {
        journalEntries.remove(atOffsets: indexSet)
    }
    
    func moveEntry(from source: IndexSet, to destination: Int) {
            journalEntries.move(fromOffsets: source, toOffset: destination)
        }
}
