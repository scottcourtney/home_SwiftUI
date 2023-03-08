//
//  SignUpView.swift
//  home
//
//  Created by Scott Courtney on 12/28/22.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    @State var signUpProcessing = false
    @State var signUpErrorMessage = ""
    @State var token = ""
    @State var userId = ""
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            Spacer()
            SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
            Button(action: {
                signUpUser(userEmail: email, userPassword: password)
            }) {
                Text("Sign Up")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true)
            if signUpProcessing {
                ProgressView()
            }
            if !signUpErrorMessage.isEmpty {
                Text("Failed creating account: \(signUpErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    viewRouter.currentPage = .signInPage
                }) {
                    Text("Log In")
                }
            }
            .opacity(0.9)
        }
        .padding()
    }
    
    func signUpUser(userEmail: String, userPassword: String) {
        
        signUpProcessing = true
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                signUpProcessing = false
                return
            }
            
            switch authResult {
            case .none:
                print("Could not create account.")
                signUpProcessing = false
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
                            ApiService().createUser(userId: userId, nickname: "1223 old road", email: userEmail, firstName: "FirstName", lastName: "LastName") { (result) in
                                if result == true {
                                    ApiService().getUserData() { (result) in
                                        print(result)
                                        withAnimation {
                                            viewRouter.currentPage = .contentPage
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                })
                
                print("User signed up")
                print("User ID = \(userInfo?.uid)")
                signUpProcessing = false
                
            }
        }
        
    }
    
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}

//struct LogoView: View {
//    var body: some View {
//        Image("Logo")
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 300, height: 150)
//            .padding(.top, 70)
//    }
//}

struct SignUpCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
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
            SecureField("Confirm Password", text: $passwordConfirmation)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
                .padding(.bottom, 30)
        }
    }
}
