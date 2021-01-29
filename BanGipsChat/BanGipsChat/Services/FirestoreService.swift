//
//  FirestoreService.swift
//  BanGipsChat
//
//  Created by BanGips on 29.01.21.
//

import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users ")
    }
    
    func saveProfileWith(id: String, email: String, userName: String?, avatarImageString: String?, description: String?, sex: String?,completion: @escaping  (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFilled(username: userName, description: description, sex: sex) else {
            completion(.failure(UserError.notField))
            return
        }
        
        let mUser = MUser(username: userName!,
                          email: email,
                          avatarStringURL: "NOT",
                          description: description!,
                          sex: sex!,
                          id: id)
        
        self.usersRef.document(mUser.id).setData(mUser.representation) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(mUser))
            }
        }
    }
    
}
