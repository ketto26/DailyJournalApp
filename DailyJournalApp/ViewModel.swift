//
//  Meneger.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 21.12.23.
//

import Foundation

class NewsManager: ObservableObject {
    @Published var journalEntries: [JournalEntry] = []
    
    func addEntry(title: String, description: String, date: Date) {
        let newEntry = JournalEntry(title: title, description: description, date: date)
        journalEntries.append(newEntry)
    }
    
    func deleteEntry(at indexSet: IndexSet) {
        journalEntries.remove(atOffsets: indexSet)
    }
    
    func moveEntry(from source: IndexSet, to destination: Int) {
            journalEntries.move(fromOffsets: source, toOffset: destination)
        }
}
