//
//  UserManager.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-03.
//

import Foundation


class UserManager {
    
    
    struct AuthentificateRequest: Encodable {
        let username: String
        var password: String
        
        init(username: String, password: String) {
            self.username = username
            self.password = password
        }
    }

    struct AuthentificationResponse: Decodable {
        let userId: Int
    }
    
    enum UserAuthentificationMethod: Codable {
        case register
        case login
    }
    
    struct UserInfo: Codable {
        let userId: Int
        let username: String
    }
    
    static var users: [User] = []

}

