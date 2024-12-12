//
//  LoginView.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(ProfileViewModel.self) private var profile
    
    @Bindable var login: LoginViewModel = LoginViewModel()
    
    @FocusState private var isLoginFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Wanaka Tracker Manager Login")
                .font(.largeTitle).foregroundColor(Color.accentColor)
                .padding([.top, .bottom], 40)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: $login.login)
                    .focused($isLoginFocused)
                
                    .onChange(of: isLoginFocused) {value, newValue in
                        let auth = Authentication(username: login.login, password: login.password)
                        profile.validate(authentication: auth)
                    }
                    .textFieldStyle(.plain)
                    .textContentType(.emailAddress)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay( RoundedRectangle(cornerRadius: 20) .stroke(Color.accentColor) )
                
                SecureField("Password", text: $login.password)
                    .textFieldStyle(.plain)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay( RoundedRectangle(cornerRadius: 20) .stroke(Color.accentColor) )
            }.padding([.leading, .trailing], 27.5)
            
            Text(profile.errorText)
                .font(.subheadline).foregroundColor(Color.red)
            
            if profile.isLoading {
                ProgressView()
            }
            
            WanakaButton(title: "Sign In") {
                Task {
                    let auth = Authentication(username: login.login, password: login.password)
                    await profile.login(authentication: auth)
                }
            }
            
            HStack(spacing: 0) {
                Text("Don't have an account? ")
                Button(action: {}) {
                    Text("Sign Up")
                        .foregroundColor(.black)
                }
            }
        }
    }
}
