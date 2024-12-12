//
//  ApplicationsViewModel.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 21/11/2024.
//

import SwiftUI

struct BusinessApplicationsModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let owner: String
}

@MainActor
@Observable class ApplicationsViewModel {
    var applications: [BusinessApplicationsModel] = []
    var showAppSheet = false
    
    private let repository: any TrackerRepositoryProtocol
    
    init() {
        #if NETWORK_MOCK
        repository = TrackerRepositoryMock()
        #else
        repository = TrackerRepository()
        #endif
    }
    
    func application(appName: String) async {
        do {
            try await repository.application(appName: appName)
            showAppSheet = false
            let apps = try await repository.application()
            self.applications = apps.applications.compactMap{BusinessApplicationsModel(name: $0.name, owner: $0.owner ?? "")}
        } catch {
            applications = []
        }
    }
    
    func applications() async {
        do {
            let apps = try await repository.application()
            self.applications = apps.applications.compactMap{BusinessApplicationsModel(name: $0.name, owner: $0.owner ?? "")}
        } catch {
            applications = []
        }
    }
}
