//
//  ContentView.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var profile = ProfileViewModel()
    
    private let repository = ApplicationsViewModel()
    
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
        
        NavigationSplitView {
            List {
                ForEach(repository.applications, id: \.id) { app in
                    NavigationLink(app.name, destination: EventsView(appName: app.name))
                }
            }
            .navigationTitle("Sidebar")
        } detail: {
            ContentUnavailableView("Select an element from the sidebar", systemImage: "doc.text.image.fill")
        }.task { @MainActor in
            await repository.applications()
        }
    }
}
