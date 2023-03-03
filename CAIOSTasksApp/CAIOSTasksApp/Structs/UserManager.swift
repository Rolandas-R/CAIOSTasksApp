//
//  UserManager.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-03.
//

import Foundation

class UserManager {
    
    
    struct AuthentificateRequest: Codable {
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

    
}

