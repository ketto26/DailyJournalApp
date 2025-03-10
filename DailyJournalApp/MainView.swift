//
//  MainView.swift
//  DailyJournalApp
//
//  Created by Keto Nioradze on 10.03.25.
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.gray)
        UITabBar.appearance().backgroundColor = UIColor(babyMintColour)
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.frame.size.height = 150
        }
    
    var body: some View {
        TabView{
            
            DailyNewsScene()
                .tabItem {
                    Label("Home", systemImage: "newspaper.fill")
                }
            ProfilePage()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
        }
        .tint(peachCustomColour)
        
    }
}


#Preview {
    MainView()
}
