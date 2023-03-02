//
//  User.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-01.
//

import Foundation

struct User: Codable {
    let username: String?
    let password: String?
    var userId: Int?
}

var user22 = User(username: "66", password: "bb", userId: 15)

