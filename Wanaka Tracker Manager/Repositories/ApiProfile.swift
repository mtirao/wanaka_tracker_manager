//
//  ApiProfile.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import Foundation

enum ApiProfile: Api {
    
    case fetchProfile(profile: String)
    case login(auth: Authentication)
    
    var server: String {
        return "http://localhost:3000"
    }
    
    var path: String {
        switch self {
        case .fetchProfile(let profile):
            return "/api/wanaka/profile/\(profile)"
        case .login:
            return "/api/wanaka/accounts/login"
        }
    }
    
    var method: String {
        switch self {
        case .fetchProfile:
            return "GET"
        case .login:
            return "POST"
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let body):
            let jsonBody = try? JSONEncoder().encode(body)
            print(String(data: jsonBody!, encoding: .utf8) ?? "")
            return jsonBody
        default:
            return nil as Data?
        }
    }
    
    var isAuthRequired: Bool {
        if case .fetchProfile = self { return true }
        return false
    }
}
