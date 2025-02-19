//
//  ContentView.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 20.12.23.
//

import SwiftUI


struct DailyNewsScene: View {
    // MARK: - Properties
    @State private var title = ""
    @State private var description = ""
    @State private var selectedDate = Date()
    @ObservedObject private var newsManager = NewsManager()
    @State private var showEmptyState = false
    
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pink
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
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
                                .background(Color.pink)
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
                        .background(Color.pink)
                        .padding()
                        .onAppear {
                            showEmptyState = newsManager.journalEntries.isEmpty
                        }
                        .background(Color.pink)
                    }
                    NavigationLink(destination: NotesView().environmentObject(newsManager)) {
                        Text("Add New Note")
                            .padding()
                            .background(Color.mint)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                    }
                }
                .background(Color.pink)
                .navigationBarTitle("My Daily Journal", displayMode: .inline)
            }
        }
    }
    
    
    // MARK: - Functions
    func deleteNews(at offsets: IndexSet) {
        newsManager.deleteEntry(at: offsets)
        showEmptyState = newsManager.journalEntries.isEmpty
    }
    
    func moveNews(from source: IndexSet, to destination: Int) {
        newsManager.moveEntry(from: source, to: destination)
    }
    
    
    // MARK: - Struck
    struct EmptyStateView: View {
        var body: some View {
            Text("List is empty.")
                .foregroundColor(.white)
        }
    }
}


#Preview {
    DailyNewsScene()
}
