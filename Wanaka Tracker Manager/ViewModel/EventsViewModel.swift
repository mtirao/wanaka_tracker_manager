//
//  EventsViewModel.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 22/11/2024.
//

import SwiftUI

struct BusinessEventsModel: Identifiable {
    let id: UUID = UUID()
    let client: String
    let event: String
    let value: String
}

@MainActor
@Observable class EventsViewModel {
    var events: [BusinessEventsModel] = []
    
    private let repository: any TrackerRepositoryProtocol
    
    init() {
        #if NETWORK_MOCK
        repository = TrackerRepositoryMock()
        #else
        repository = TrackerRepository()
        #endif
    }
    
    func events(appName: String) async {
        do {
            let events = try await repository.events(appName: appName)
            self.events = events.events.compactMap{
                BusinessEventsModel(client: $0.client, event: $0.event, value: $0.value)
            }
        } catch {
            events = []
        }
    }
}
