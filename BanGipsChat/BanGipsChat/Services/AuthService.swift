//
//  AuthService.swift
//  BanGipsChat
//
//  Created by BanGips on 29.01.21.
//

import UIKit
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService() 
    
    private let auth = Auth.auth()
    
    func login(email: String?, password: String?, completion: @escaping  (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else { completion(.failure(error!)); return }
            completion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, cofirmPassword: String?, completion: @escaping  (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else { completion(.failure(error!)); return }
            completion(.success(result.user))
        }
        
    }
    
}
