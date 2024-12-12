//
//  ApiTracker.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 21/11/2024.
//

import Foundation

enum ApiTracker: Api {
    
    case fetchApplications
    case createApplication(appName: Application)
    case fetchEvents(appName: String)
    
    var server: String {
        return "http://localhost:4000"
    }
    
    var path: String{
        switch self {
            case .createApplication: return "/api/application"
            case .fetchApplications: return "/api/applications"
            case .fetchEvents(let appName): return "/api/events/\(appName)"
        }
    }
    
    var method: String {
        switch self {
        case .createApplication: return "POST"
        case .fetchApplications: return "GET"
        case .fetchEvents: return "GET"
        }
    }
    
    var body: Data? {
        switch self {
        case .createApplication(let body):
            let jsonEncoder = JSONEncoder()
            return try? jsonEncoder.encode(body)
        case .fetchApplications: return nil
        case .fetchEvents: return nil
        }
    }
    
    var isAuthRequired: Bool {
        return true
    }
}
