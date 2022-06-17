//
//  CurrentUser.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/16/22.
//

import Foundation

class CurrentUser {
    var name : String
    var email : String
    var mobile : String
    
    init(name: String, email: String, mobile: String) {
        self.name = name
        self.email = email
        self.mobile = mobile
    }
}
