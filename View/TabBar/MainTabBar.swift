//
//  MainTabBar.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 13.05.2022.
//


import SwiftUI

struct MainTabBar: View {
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        
        // Создаём саму форму
        TabView {
            CatalogView()
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Материал")
                    }
                }
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
}

//struct MainTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabBar(viewModel: <#T##MainTabBarViewModel#>(user: User))
//    }
//}
