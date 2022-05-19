//
//  langLearnUser.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 17.05.2022.
//

import Foundation

struct llUser: Identifiable {
    
    var id: String
    var name: String
    var phone: Int
    var progress: String
    var email: String
    
    var representasion: [String: Any] {
        
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["progress"] = self.progress
        repres["email"] = self.email
        
        return repres
    }
}
