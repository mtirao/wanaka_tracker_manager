//
//  Network.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import Foundation

public enum NetworkError: Error {
        
    case invalidURL
}

protocol Api {
    var server: String { get }
    var path: String { get }
    var method: String { get }
    var body: Data? { get }
    var isAuthRequired: Bool { get } 
    func asUrlRequest() throws -> URLRequest
}

extension Api {
    func asUrlRequest() throws -> URLRequest {
        
        let urlString = server + path
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = method
        
        if isAuthRequired {
            if let token = try? Keychain.shared.retrieve(), let tkn = String(data:token, encoding: .utf8) {
                request.addValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization")
            }
        }
        request.httpBody = body
        
        return request
    }
}
