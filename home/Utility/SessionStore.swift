//
//  SessionStore.swift
//  home
//
//  Created by Scott Courtney on 1/4/23.
//

import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: UserInfo? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = UserInfo(
                    uid: user.uid,
                    displayName: user.displayName
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    func signUp(
            email: String,
            password: String,
            handler: @escaping(AuthDataResult?, Error?) -> Void
            ) {
            Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        }

        func signIn(
            email: String,
            password: String,
            handler: @escaping(AuthDataResult?, Error?) -> Void
            ) {
            Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        }

        func signOut () -> Bool {
            do {
                try Auth.auth().signOut()
                self.session = nil
                return true
            } catch {
                return false
            }
        }
    
    func unbind () {
            if let handle = handle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
