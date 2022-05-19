//
//  DataBaseServices.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 17.05.2022.
//

import Foundation
import FirebaseFirestore

class DatabaseServices {
    
    static let shared = DatabaseServices()
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private init() {
    }
    
    // Метод, который при регистрации пользователя отображает в базу данных 
    func setUser(user: llUser, completion: @escaping (Result<llUser, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representasion) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
