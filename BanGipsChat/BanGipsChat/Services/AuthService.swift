//
//  AuthService.swift
//  BanGipsChat
//
//  Created by BanGips on 29.01.21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class AuthService {
    
    static let shared = AuthService() 
    
    private let auth = Auth.auth()
    
    func login(email: String?, password: String?, completion: @escaping  (Result<User, Error>) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFailled))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else { completion(.failure(error!)); return }
            completion(.success(result.user))
        }
    }
    
    func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping  (Result<User, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let auth = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            guard let result = result else { completion(.failure(error!))
                return }
            
            completion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, cofirmPassword: String?, completion: @escaping  (Result<User, Error>) -> Void) {
        
        guard Validators.isFilled(email: email, password: password, confirmPassword: cofirmPassword) else {
            completion(.failure(AuthError.notFailled))
            return
        }
        
        guard password!.lowercased() == cofirmPassword!.lowercased() else {
            completion(.failure(AuthError.passwordNotMathced))
            return
        }
        
        guard  Validators.isValidEmail(email!) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else { completion(.failure(error!)); return }
            completion(.success(result.user))
        }
        
    }
    
}
