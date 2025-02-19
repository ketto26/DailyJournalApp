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
                                .contextMenu {
                                    Button("Delete") {
                                        if let index = newsManager.journalEntries.firstIndex(where: { $0.id == entry.id }) {
                                            newsManager.journalEntries.remove(at: index)
                                        }
                                    }
                                }
                                .padding()
                            }
                            .onMove(perform: moveNews)
                            .onDelete(perform: deleteNews)
                            .frame(height: 100)
                            
                            // MARK: - change rows colours to colourful
                            .listRowBackground(
                                Rectangle()
                                    .fill(Color(.white).opacity(0.85))
                                    .cornerRadius(10.0)
                                    .padding(4))
                            .listRowSeparator(.hidden)
                        }
                        
                        .scrollContentBackground(.hidden)
                        .padding()
                        .onAppear {
                            showEmptyState = newsManager.journalEntries.isEmpty
                        }
                    }
                    NavigationLink(destination: NotesView().environmentObject(newsManager)) {
                        Text("Add New Note")
                            .padding()
                            .background(Color(.white).opacity(0.85))
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                    }
                    
                }
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
