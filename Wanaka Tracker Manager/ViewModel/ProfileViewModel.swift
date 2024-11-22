//
//  ProfileViewModel.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import SwiftUI

@MainActor
@Observable class ProfileViewModel {
    
    var isNeededAuthentication: Bool = true
    var errorText: String = " "
    var profile: Profile? = nil
    var isLoading = false
    var token: String?
    
    private let repository: any ProfileRepositoryProtocol
    
    init() {
        #if NETWORK_MOCK
        repository = ProfileRepositoryMock()
        #else
        repository = ProfileRepository()
        #endif
    }
    
    @discardableResult
    func validate(authentication: Authentication) -> Bool {
        guard !authentication.username.isEmpty else { return true }
        let result = authentication.username.matches(Regex.email)
        errorText = result ? "" : "Invalid email."
        return result
    }
    
    func login(authentication: Authentication) async {
        guard validate(authentication: authentication) else {
            return
        }
        
        isLoading = true
        
        errorText = ""
        do {
            let jwtToken = try await repository.login(auth: authentication)
            
            token = jwtToken.accessToken
            
            if let token {
                try Keychain.shared.store(token.data(using: .utf8)!)
                isNeededAuthentication = false
            }
            isLoading = false
        }catch {
            isLoading = false
            print(error.localizedDescription)
            errorText = "\(error.localizedDescription) Try again later"
        }
    }
}
