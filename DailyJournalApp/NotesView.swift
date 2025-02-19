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
    //  @State private var title = ""
    @State private var description = ""
    @State private var selectedDate = Date()
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    var extractedTitle: String {
        let separators: CharacterSet = ["\n", "."]
        let sentences = description.components(separatedBy: separators)
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        return sentences.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Untitled"
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.pink
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Text(extractedTitle)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing, .top])
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $description)
                        .foregroundColor(.pink)
                        .padding(10)
                        .frame(minHeight: 200)
                        .shadow(radius: 5)
                        .padding([.leading, .trailing, .bottom])
                    
                    if description.isEmpty {
                        Text("Start your daily adventures...")
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                            .padding(.leading, 40)
                            .font(.body)
                    }
                }
                
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding()
                
                HStack{
                    Button("Select Photo") {
                        showImagePicker = true
                    }
                    .padding()
                    
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding()
                    }
                    
                    Button("Save News") {
                        saveNews()
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showImagePicker) {
                PhotoPicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
            }
        }
    }
    
    // MARK: - Functions
    func saveNews() {
        newsManager.addEntry(title: extractedTitle, description: description, date: selectedDate, image: selectedImage)
        description = ""
        selectedImage = nil
    }
}



#Preview {
    NotesView()
}
