//
//  Task.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-01.
//

import Foundation

struct Task: Codable {
    
    let id: Int
    let title: String
    let description: String
    var estimateMinutes: Int
    var assigneeInfo: Assignee
    var loggedTime: Int
    var isDone: Bool
}

struct Assignee: Codable {
    var id: Int
    var username: String
}


