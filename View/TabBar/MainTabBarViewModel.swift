//
//  MainTabBarViewModel.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 13.05.2022.
//

import Foundation
import FirebaseAuth
import Firebase

class MainTabBarViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
