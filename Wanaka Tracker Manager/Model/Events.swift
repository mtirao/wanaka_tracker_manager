//
//  Events.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 22/11/2024.
//

import Foundation


struct Event: Codable {
    let client: String
    let event: String
    let value: String
    let app: Application
}

struct Events: Codable {
    let events: [Event]
}
