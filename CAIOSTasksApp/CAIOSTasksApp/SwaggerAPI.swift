//
//  SwaggerAPI.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-01.
//

import Foundation

enum Constants: String {
    case baseURL = "http://134.122.94.77/api/"
    case userEndpoint = "User/"
    case taskEndpoint = "Task/"
    
    enum SubEndpoints: String {
        case register = "register"
        case userTasks = "userTasks"
    }
    
    static func getURL(for constant: Constants,
                       subEndpoint: SubEndpoints? = nil,
                       id: Int? = nil) -> URL {
        var urlString = baseURL.rawValue + constant.rawValue
        if let id {
            urlString = baseURL.rawValue + constant.rawValue + String(id)
        } else if subEndpoint != nil {
            urlString = baseURL.rawValue + constant.rawValue + (subEndpoint?.rawValue ?? "")
        }
        return URL(string: urlString)!
    }
    
    static func buildGetUserTasksURL() -> URL? {
        let url = getURL(for: .taskEndpoint, subEndpoint: .userTasks)
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let userIdQueryItem = URLQueryItem(name: "userId", value: String(user.id ?? 0))
            let queryItems = [userIdQueryItem]
            components?.queryItems = queryItems
            guard let queryURL = components?.url else { return nil }
            return queryURL
    }
}

enum APIErorr: Error {
    
}

