//
//  EventsView.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 22/11/2024.
//

import SwiftUI


struct EventsView: View {

    private let events = EventsViewModel()
    
    let appName: String
    
    var body: some View {
        Table(events.events) {
            TableColumn("Client", value: \.client)
            TableColumn("Event", value: \.event)

            TableColumn("Value", value: \.value)
        }.task { @MainActor in
            await events.events(appName: appName)
        }
    }
}
