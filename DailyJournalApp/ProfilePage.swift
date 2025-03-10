//
//  HomePage.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 10.03.25.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        ZStack{
            peachCustomColour
                .edgesIgnoringSafeArea(.all)
            
            Text("Profile")
                .foregroundStyle(.white)
        }
        
    }
}


#Preview {
    ProfilePage()
}
