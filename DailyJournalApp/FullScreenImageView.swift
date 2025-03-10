//
//  FullScreenImageView.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 10.03.25.
//

import SwiftUI

struct FullScreenImageView: View {
    let image: UIImage
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                Spacer()
            }
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()  // This ensures the image maintains aspect ratio
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)  // Prevents weird transparency issues
        }
    }
}
