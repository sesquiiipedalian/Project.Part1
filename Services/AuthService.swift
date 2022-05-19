//
//  AuthService.swift
//  Auth without storyboard
//
//  Created by Азамат Кемал on 13.05.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    static let shared = AuthService()
    
    // Дабы никто не скопипастил экземпляр AuthService
    private init() { }
    
    private let auth = Auth.auth()
    
    private let db = Firestore.firestore()
    
    // типа текущий пользователь
    var currentUser: User? {
        return auth.currentUser
    }
    
    // метод для регистрации пользователя
    //completion - сбегающее замыкание
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> () ) {
        
        auth.createUser(withEmail: email,
                        password: password) { result, error in
            if let result = result {
                //создание юзера
                let ll_user = llUser(id: result.user.uid,
                                     name: "",
                                     phone: 0,
                                     progress: "",
                                    email: email)
                DatabaseServices.shared.setUser(user: ll_user) { resultDB in
                    switch resultDB {
                    case.success(_):
                        completion(.success(result.user))
                    case.failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                completion(.failure(error)) //
            }
        }
//        let docRef = db.collection("users").document("users")
//
//        docRef.getDocument(source: .cache) { (document, error) in
//            if let document = document {
//                var usersNum = document.get("amount") as? Int
//                usersNum! += 1
//                document.setValue(usersNum, forKeyPath: "amount")
//            }
//
//        }
    }
    // Авторизация пользователя в приложении
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> () ) {
        
        
        auth.signIn(withEmail: email, password: password) { result, error in
            
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
    }
}
