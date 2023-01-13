//
//  SignInView.swift
//  home
//
//  Created by Scott Courtney on 12/28/22.
//

import SwiftUI
import Firebase

struct SignInView: View {
        
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    @State var token = ""
    @State var userId = ""

    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            Spacer()
            SignInCredentialFields(email: $email, password: $password)
            Button(action: {
                signInUser(userEmail: email, userPassword: password)
            }) {
                Text("Log In")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            .disabled(!signInProcessing && !email.isEmpty && !password.isEmpty ? false : true)
            if signInProcessing {
                ProgressView()
            }
            if !signInErrorMessage.isEmpty {
                Text("Failed creating account: \(signInErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    viewRouter.currentPage = .signUpPage
                }) {
                    Text("Sign Up")
                }
            }
            .opacity(0.9)
        }
        .padding()
    }

    func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user.")
                signInProcessing = false
            case .some(_):
                
                let userInfo = Auth.auth().currentUser
                self.userId = userInfo!.uid
                let defaults = UserDefaults.standard
                defaults.set(userInfo?.uid, forKey: "UserId")
                defaults.set(userInfo?.email, forKey: "UserEmail")
                
                userInfo?.getIDToken(completion: { (token,err) in
                    if err != nil {
                        print("Token error: \(String(describing: err))")
                    } else {
                        print("Token:  \(String(describing: token))")
                        if let token = token {
                            let accessToken = token
                            let data = Data(accessToken.utf8)
                            KeychainService.standard.save(data, service: "access-token", account: "firebase")
                            ApiService().getUserData(userId: userId) { (result) in
                                    print(result)
                                    withAnimation {
                                        viewRouter.currentPage = .contentPage
                                    }
                                }
                        
                        }
                        
                    }
                })
                
                print("User signed in")
                print("User ID = \(String(describing: userInfo?.uid))")
                signInProcessing = false
                
            }
            
        }
        
    }
}

//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInView()
//    }
//}

struct SignInCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(.bottom, 30)
        }
    }
}
