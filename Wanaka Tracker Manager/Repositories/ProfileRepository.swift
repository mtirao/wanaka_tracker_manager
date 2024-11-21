//
//  ProfileRepository.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import Foundation

@MainActor
protocol ProfileRepositoryProtocol {
    func profile(id: String, token: String?) async throws -> Profile
    func login(auth: Authentication) async throws -> JwtToken
}

final class ProfileRepositoryMock: ProfileRepositoryProtocol {
    func profile(id: String, token: String?) async throws -> Profile {
        Profile(cellPhone: "", email: "", firstName: "", lastName: "", phone: "", userRole: nil, profileId:nil, gender: "", address: "", city: "")
    }
    
    func login(auth: Authentication) async throws -> JwtToken {
        return JwtToken(accessToken: "", tokeType: "", refreshToken: "")
    }
}


final class ProfileRepository: ProfileRepositoryProtocol {
    
    func profile(id: String, token: String?) async throws -> Profile {
        let session = URLSession.shared
        let (data, _) = try await session.data(for: ApiProfile.fetchProfile(profile: id).asUrlRequest(token: token))
        let profileResult = try JSONDecoder().decode(Profile.self, from: data)
        return profileResult
    }
    
    func login(auth: Authentication) async throws -> JwtToken {
        let (data, _) = try await URLSession.shared.data(for: ApiProfile.login(auth: auth).asUrlRequest())
        let profileResult = try JSONDecoder().decode(JwtToken.self, from: data)
        return profileResult
    }
    
}
