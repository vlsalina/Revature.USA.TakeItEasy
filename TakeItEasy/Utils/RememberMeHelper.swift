//
//  rememberMeHelper.swift
//  FunZoneApp
//
//  Created by Vincent Salinas on 6/1/22.
//

import Foundation

class RememberMeHelper {
    
    static func save(userid: String, password: String) {
        do {
            try KeychainManager.save(service: App, userid: userid, password: password.data(using: .utf8) ?? Data())
            userDefaults.set(userid, forKey: "userdefault-email")
        } catch {
            print(error)
        }
        
    }
    
    static func get(userid: String) -> String {
        
        guard let data = KeychainManager.get(service: App, userid: userid) else {
            print("Failed to read password")
            return "Failed to read password"
        }
        
        let password = String(decoding: data, as: UTF8.self)
        print("Password: \(password)")
        
        return password
        
    }
    
    
}

