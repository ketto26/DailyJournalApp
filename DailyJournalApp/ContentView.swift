//
//  ContentView.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 20.12.23.
//

import SwiftUI


struct DailyNewsScene: View {
    @State private var title = ""
    @State private var description = ""
    @State private var selectedDate = Date()
    @ObservedObject private var newsManager = NewsManager()
    @State private var showEmptyState = false
    
    var body: some View {
        VStack {
            TextField("Enter Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.cyan, width: 2)
                .padding()
            
            TextEditor(text: $description)
                .frame(minHeight: 200)
                .border(Color.cyan, width: 2)
                .padding()
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding()
            
            Button("Save News") {
                saveNews()
            }
            .padding()
            
            if newsManager.journalEntries.isEmpty {
                EmptyStateView()
                    .padding()
            } else {
                List {
                    ForEach(newsManager.journalEntries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .font(.headline)
                            Text(entry.description)
                                .foregroundColor(.gray)
                            Text(entry.date, style: .date)
                                .foregroundColor(.blue)
                        }
                        .contextMenu {
                            Button("Delete") {
                                if let index = newsManager.journalEntries.firstIndex(where: { $0.id == entry.id }) {
                                    newsManager.journalEntries.remove(at: index)
                                }
                            }
                        }
                    }
                    .onMove(perform: moveNews)
                    .onDelete(perform: deleteNews)
                }
                .padding()
                .onAppear {
                    showEmptyState = newsManager.journalEntries.isEmpty
                }
            }
        }
    }
    
    func saveNews() {
        newsManager.addEntry(title: title, description: description, date: selectedDate)
        title = ""
        description = ""
    }
    
    func deleteNews(at offsets: IndexSet) {
        newsManager.deleteEntry(at: offsets)
        showEmptyState = newsManager.journalEntries.isEmpty
    }
    
    func moveNews(from source: IndexSet, to destination: Int) {
        newsManager.moveEntry(from: source, to: destination)
    }
    
    struct EmptyStateView: View {
        var body: some View {
            Text("List is empty.")
                .foregroundColor(.gray)
        }
    }
}


#Preview {
    DailyNewsScene()
}
