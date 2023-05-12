//
//  FirebaseAuthManager.swift
//  SwiftLibray
//
//  Created by Fatih Durmaz on 13.05.2023.
//

import FirebaseAuth
import SwiftUI

class FirebaseAuthManager: ObservableObject {
    @Published var isLoggedIn = false
    
    // Kullanıcıyı kaydeder
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Kayıt hatası: \(error.localizedDescription)")
            } else {
                print("Başarıyla kaydedildi: \(authResult?.user.uid ?? "")")
                self.isLoggedIn = true
            }
        }
    }

    // Kullanıcıyı oturum açar
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Giriş hatası: \(error.localizedDescription)")
            } else {
                print("Başarıyla giriş yapıldı: \(authResult?.user.uid ?? "")")
                self.isLoggedIn = true
            }
        }
    }

    // Kullanıcı oturumu kapatır
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Oturum kapatma hatası: \(signOutError.localizedDescription)")
        }
    }
}
