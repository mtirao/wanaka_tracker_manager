//
//  ContentView.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var profile = ProfileViewModel()
    
    var body: some View {
        if profile.isNeededAuthentication {
            Rectangle()
                .sheet(isPresented: $profile.isNeededAuthentication) {
                    LoginView()
                        .environment(profile)
                }
        }else {
            MainView()
        }
    }
    
    @ViewBuilder
    func MainView() -> some View {
        Text("Hello World!")
    }
}
