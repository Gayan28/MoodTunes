//
//  AuthModel.swift
//  MoodTunes
//
//  Created by Gayan Kavinda on 2025-04-14.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    private let db = Firestore.firestore()
    
    init() {
        self.currentUser = Auth.auth().currentUser
        self.isAuthenticated = currentUser != nil
    }
    
    func signUp(
        fullName: String,
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let userData = [
                    "uid": uid,
                    "fullName": fullName,
                    "email": email
                ]
                
                self.db.collection("users").document(uid).setData(userData) { err in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        self.currentUser = result?.user
                        self.isAuthenticated = true
                        completion(.success(()))
                    }
                }
            }
        }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self.currentUser = result?.user
            self.isAuthenticated = true
            completion(.success(()))
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
        self.currentUser = nil
        self.isAuthenticated = false
    }
}
