//
//  Profile.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import Foundation

struct JwtToken: Codable {
    let accessToken: String
    let tokeType: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accesstoken"
        case tokeType = "tokentype"
        case refreshToken = "refreshtoken"
    }
}

struct Profile: Codable {
    
    let cellPhone: String
    let email: String
    let firstName: String
    let lastName: String
    let phone: String
    let userRole: String?
    let profileId: Int?
    let gender: String
    let address: String
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case cellPhone = "cellphone"
        case email = "email"
        case firstName = "firstname"
        case lastName = "lastname"
        case phone = "phone"
        case userRole = "userrole"
        case profileId = "profileid"
        case gender = "gender"
        case address = "address"
        case city = "city"
    }
}

