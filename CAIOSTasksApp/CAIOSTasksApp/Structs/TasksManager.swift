//
//  TasksManager.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-03.
//

import Foundation

class TasksManager{
    
    struct NewTaskRegistrationRequest: Codable {
        let title: String
        let description: String
        let estimateMinutes: Int
        let assigneeId: Int
    }
    struct NewTaskResponce: Codable {
        let id: Int
    }
}