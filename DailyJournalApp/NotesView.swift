//
//  NotesView.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 19.02.25.
//

import SwiftUI

struct NotesView: View {
    // MARK: - Properties
    @EnvironmentObject var newsManager: NewsManager
    var entryToEdit: JournalEntry? // New parameter for editing existing entry
    @State private var description: String
    @State private var selectedImages: [UIImage]
    @State private var showImagePicker = false
    @State private var showConfirmationMessage = false
    @State private var selectedImageForPreview: UIImage?

    // Extract title from description
    private var extractedTitle: String {
        let separators: CharacterSet = ["\n", "."]
        let sentences = description.components(separatedBy: separators)
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        return sentences.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Untitled"
    }

    // MARK: - Initializer
    init(entryToEdit: JournalEntry? = nil) {
        _description = State(initialValue: entryToEdit?.description ?? "")
        _selectedImages = State(initialValue: entryToEdit?.images ?? [])
        self.entryToEdit = entryToEdit
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            peachCustomColour
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack(alignment: .topLeading) {
                    if description.isEmpty {
                        Text("Start your daily adventures...")
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.leading, 40)
                            .font(.body)
                            .opacity(0.5)
                    }

                    TextEditor(text: $description)
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .padding(10)
                        .frame(minHeight: 30)
                        .padding([.leading, .trailing, .bottom])
                }

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .padding(5)
                                .onTapGesture {
                                    selectedImageForPreview = image
                                }
                        }
                    }
                }

                HStack {
                    Button("Select Photos") {
                        showImagePicker = true
                    }
                    .padding()

                    Button("Save News") {
                        saveNews()
                    }
                    .padding()
                }
                .tint(.white)

                Spacer()
                Spacer()

                if showConfirmationMessage {
                    Text("News Saved!")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                PhotoPicker(selectedImages: $selectedImages, sourceType: .photoLibrary)
            }
        }
    }

    // MARK: - Functions
    func saveNews() {
        let currentDate = Date()

        if let existingEntry = entryToEdit, let index = newsManager.journalEntries.firstIndex(where: { $0.id == existingEntry.id }) {
            // Editing existing entry
            newsManager.journalEntries[index].title = extractedTitle
            newsManager.journalEntries[index].description = description
            newsManager.journalEntries[index].date = currentDate
            newsManager.journalEntries[index].images = selectedImages
        } else {
            // Creating new entry
            newsManager.addEntry(title: extractedTitle, description: description, date: currentDate, images: selectedImages)
        }

        description = ""
        selectedImages = []
        showConfirmationMessage = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showConfirmationMessage = false
        }
    }
}




#Preview {
    NotesView()
}
