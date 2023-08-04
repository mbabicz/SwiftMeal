//
//  UserViewModel.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 01/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    
    @Published var activeSheet: ActiveSheet? = nil
    
    enum ActiveSheet {
        case signIn, signUp
    }
    
    private var db: Firestore { Firestore.firestore(app: FirebaseApp.app(name: "SwiftMealDelivery")!) }
    private let auth = Auth.auth(app: FirebaseApp.app(name: "SwiftMealDelivery")!)
    
    @Published var user: User?
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
        
    var uuid: String? {
        return auth.currentUser?.uid
    }
    
    var userIsAuthenticated: Bool {
        return auth.currentUser != nil
    }
    
    var userIsAuthenticatedAndSynced: Bool {
        return user != nil && userIsAuthenticated
    }
    
    func updateAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.showingAlert = true
    }

    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.updateAlert(title: "Error", message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.addUser(User(signUpDate: Date.now, userEmail: email))
                    self.syncUser()
                }
            }
        }
    }
    
    func syncUser(){
        guard userIsAuthenticated else { return }
        db.collection("Users").document(self.uuid!).getDocument { document, error in
            guard document != nil, error == nil else { return }
            do{
                try self.user = document!.data(as: User.self)
            } catch{
                print("sync error: \(error)")
            }
        }
    }
    
    private func addUser(_ user: User){
        guard userIsAuthenticated else { return }
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)

        } catch {
            print("Error adding: \(error)")
        }
    }

}
