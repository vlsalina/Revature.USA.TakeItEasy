//
//  KeychainManager.swift
//  FunZoneApp
//
//  Created by Vincent Salinas on 6/1/22.
//

import Foundation

class KeychainManager {
    
    static func save(service : String, userid : String, password : Data) throws {
        
        // service, account, class, data
        let query : [String : AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: userid as AnyObject,
            kSecValueData as String: password as AnyObject
            
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown
        }
        
        print("Saved")
        
    }
    
    static func get(service : String, userid : String) -> Data? {
        
        // service, account, class, data
        let query : [String : AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: userid as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result : AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        print("Status: \(status)")
        
        return result as? Data
        
    }
    
}

