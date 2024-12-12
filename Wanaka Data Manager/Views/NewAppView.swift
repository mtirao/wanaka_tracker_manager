//
//  NewAppView.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 22/11/2024.
//

import SwiftUI

struct NewAppView: View {
    
    @Environment(ApplicationsViewModel.self) private var applications
    
    @State private var appName: String = ""
    
    @FocusState private var isLoginFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 15) {
                TextField("New App Name", text: $appName)
                    .focused($isLoginFocused)
                    .textFieldStyle(.plain)
                    .textContentType(.emailAddress)
                    .padding()
                    .cornerRadius(20.0)
                    .overlay( RoundedRectangle(cornerRadius: 20) .stroke(Color.accentColor) )
            }.padding([.leading, .trailing], 27.5)
            
            WanakaButton(title: "Save New App") {
                Task {@MainActor in
                    await applications.application(appName: appName)
                }
            }
        }.padding(.vertical, 32)
    }
}
