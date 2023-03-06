//
//  User.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-01.
//

import Foundation

class User: Codable {
    let username: String?
    let password: String?
    var userId: Int?
    
    init(username: String?, password: String?, userId: Int? = nil) {
        self.username = username
        self.password = password
        self.userId = userId
    }
}

var user22 = User(username: "Marijons", password: "Latvis", userId: 607)

