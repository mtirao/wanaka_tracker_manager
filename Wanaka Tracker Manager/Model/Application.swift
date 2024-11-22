//
//  Application.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 21/11/2024.
//

import Foundation

struct Application: Codable {
    let name: String
    let owner: String
}

struct Applications: Codable {
    let applications: [Application]
}
