//
//  User.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-01.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
    var id: Int?
}

let user = User(username: "dd", password: "bb", id: 83)

