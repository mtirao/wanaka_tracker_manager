//
//  String+Extension.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import Foundation

enum Regex: String {
    case login = "^[a-zA-Z][a-zA-Z0-9]{2,49}$"
    case email = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,49}$"
    case password = "^[a-zA-Z][a-zA-Z0-9]{7,11}$"
}

extension String {
    func matches(_ regex: Regex) -> Bool {
        return self.range(of: regex.rawValue, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
