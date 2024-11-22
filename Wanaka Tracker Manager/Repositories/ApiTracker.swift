//
//  ApiTracker.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 21/11/2024.
//

import Foundation

enum ApiTracker: Api {
    
    case fetchApplications
    case fetchEvents(appName: String)
    
    var server: String {
        return "http://localhost:4000"
    }
    
    var path: String{
        switch self {
            case .fetchApplications: return "/api/applications"
            case .fetchEvents(let appName): return "/api/events/\(appName)"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var body: Data? {
        return nil
    }
    
    var isAuthRequired: Bool {
        return true
    }
}
