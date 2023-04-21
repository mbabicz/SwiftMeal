//
//  UserViewModel.swift
//  SwiftMeal
//
//  Created by kz on 21/04/2023.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserViewModel: ObservableObject {
    
    private let auth = Auth.auth()
    @Published var user: User?
    let db = Firestore.firestore()
    var uuid: String? {
        return auth.currentUser?.uid
    }

    var userIsAuthenticated: Bool {
        return auth.currentUser != nil && auth.currentUser?.uid != nil
    }
    
    var userIsAuthenticatedAndSynced: Bool {
        return user != nil && userIsAuthenticated
    }
    
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously(completion: { (authResult, error) in
            if let error = error {
                print("Cant sign in anonymously: \(error.localizedDescription)")
                return
            }
            
            let docRef = self.db.collection("Users").document(self.uuid!)
            let data: [String: Any] = [
                "signUpDate": Date()
            ]
            
            docRef.setData(data) { (error) in
                if let error = error {
                    print("Cant create new document for user: \(error.localizedDescription)")
                    return
                }
                print("Succesfully added new user: \(self.uuid!)")
                //if created sync user with model
                self.syncUser()

            }
        })
    }
    
    func syncUser(){
        guard userIsAuthenticated else { return }
        db.collection("Users").document(self.uuid!).getDocument { document, error in
            guard document != nil, error == nil else { return }
            do{
                try self.user = document!.data(as: User.self)
            } catch{
                print("sync error: \(error)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {  // create new acc if got problem with sync
                    self.signOut()
                    self.signInAnonymously()
                }
            }
        }
    }
    
    func signOut(){
        do{
            try auth.signOut()
            self.user = nil
        }
        catch{
            print("Error signing out user: \(error)")
        }
    }
    
}
