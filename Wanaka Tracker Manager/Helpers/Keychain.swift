//
//  Keychain.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 21/11/2024.
//

import Foundation
import Security

class Keychain {
    
    public enum Error: Swift.Error {
        case deletionFailed
        case updateFailed
        case saveFailed
        case noData
        case decodingError
        case encodingError
    }
    
    private let key = "com.ar.argsoftsolutions.Wanaka-Tracker-Manager"

    private let secMatchLimit: String = kSecMatchLimit as String
    private let secReturnData: String = kSecReturnData as String
    private let secValueData: String = kSecValueData as String
    private let secClass: String = kSecClass as String
    private let secAttrGeneric: String = kSecAttrGeneric as String
    private let secAttrAccount: String = kSecAttrAccount as String
    private let secReturnAttributes: String = kSecReturnAttributes as String
    
    static let shared = Keychain()
    
    func store(_ value: Data) throws {
        
        var keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key)

        keychainQueryDictionary[secValueData] = value

        let status: OSStatus = SecItemAdd(keychainQueryDictionary as CFDictionary, nil)

        switch status {
        case errSecSuccess:
            return
        case errSecDuplicateItem:
            try update(value, forKey: key)
        default:
            throw Error.saveFailed
        }
    }
    
    func retrieve() throws -> Data {
        guard let data = data(forKey: key) else { throw Error.noData }
        return data
    }
    
    private func data(forKey key: String) -> Data? {
        var keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key)
        keychainQueryDictionary[secMatchLimit] = kSecMatchLimitOne
        keychainQueryDictionary[secReturnData] = kCFBooleanTrue

        var result: AnyObject?
        let status = SecItemCopyMatching(keychainQueryDictionary as CFDictionary, &result)

        return status == noErr ? result as? Data : nil
    }
    
    private func update(_ value: Data, forKey key: String) throws {
        let keychainQueryDictionary: [String: Any] = setupKeychainQueryDictionary(forKey: key)
        let updateDictionary = [secValueData: value]

        // Update
        let status: OSStatus = SecItemUpdate(
            keychainQueryDictionary as CFDictionary, updateDictionary as CFDictionary
        )

        guard status == errSecSuccess else {
            throw Error.updateFailed
        }
    }
    
    private func setupKeychainQueryDictionary(forKey key: String) -> [String: Any] {
        var keychainQueryDictionary: [String: Any] = [secClass: kSecClassGenericPassword]

        let encodedIdentifier: Data? = key.data(using: String.Encoding.utf8)
        keychainQueryDictionary[secAttrGeneric] = encodedIdentifier
        keychainQueryDictionary[kSecAttrAccount as String] = encodedIdentifier
        keychainQueryDictionary[kSecAttrSynchronizable as String] = kCFBooleanFalse

        return keychainQueryDictionary
    }
}
