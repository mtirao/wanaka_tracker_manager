//
//  TrackerRepository.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 21/11/2024.
//

import Foundation

@MainActor
protocol TrackerRepositoryProtocol {
    func application() async throws -> Applications
    func events(appName: String) async throws -> Events
}

final class TrackerRepositoryMock: TrackerRepositoryProtocol {
    func application() async throws -> Applications {
        Applications(applications: [])
    }
    func events(appName: String) async throws -> Events {
        Events(events: [])
    }
}

final class TrackerRepository: TrackerRepositoryProtocol {
    func application() async throws -> Applications {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiTracker.fetchApplications.asUrlRequest())
        let appsResult = try JSONDecoder().decode(Applications.self, from: data)
        return appsResult
    }
    
    func events(appName: String) async throws -> Events {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiTracker.fetchEvents(appName: appName).asUrlRequest())
        let eventsResult = try JSONDecoder().decode(Events.self, from: data)
        return eventsResult
    }
}