//
//  UserManager.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-03.
//

import Foundation

struct CreatedUser {
    let user: User?
    let errorTitle: String?
    let mistakeDescription: String?
}

class UserManager {
    
    
    struct AuthentificateRequest: Encodable {
        var username: String
        var password: String
        
        init(username: String, password: String) {
            self.username = username
            self.password = password
        }
    }

    struct UserResponse: Codable {
        let userId: Int
    }
    
    enum UserAuthentificationMethod: Codable {
        case register
        case login
    }
    
    static var users: [User] = []

    
}

