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
        
        init(title: String, description: String, estimateMinutes: Int, assigneeId: Int) {
            self.title = title
            self.description = description
            self.estimateMinutes = estimateMinutes
            self.assigneeId = assigneeId
        }
    }
    struct TaskRequest: Codable {
        let id: Int
    }
    struct TaskEditRequest: Encodable {
        let id: Int
        let title: String
        let description: String
        let estimateMinutes: Int
        let assigneeId: Int
        let loggedTime: Int
        let isDone: Bool
        
    }
    
    let taskRequest = TaskRequest(id: 502)
}
