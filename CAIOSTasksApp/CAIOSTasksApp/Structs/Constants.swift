//
//  Constants.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-01.
//

import Foundation

enum Constants: String {
    case baseURL = "http://134.122.94.77/api/"
    case userEndpoint = "User/"
    case taskEndpoint = "Task/"
    
    enum URLSuffix: String {
        case register = "register/"
        case login = "login/"
        case userTasks = "/api/Task/userTasks"
    }
    
    
    static func getURL(for constant: Constants,
                       urlSuffix: URLSuffix? = nil,
                       id: Int? = nil) -> URL? {
        
        var urlString = baseURL.rawValue + constant.rawValue
        if let id {
            urlString = baseURL.rawValue + constant.rawValue + String(id)
        } else if let urlSuffix {
            urlString = baseURL.rawValue + constant.rawValue + urlSuffix.rawValue
        }
        return URL(string: urlString)
    }
    
    static func buildURLWithParams(userId: Int?) -> URL? {
            
        var components = URLComponents()
        components.scheme = "http"
        components.host = "134.122.94.77"
        components.path = Constants.URLSuffix.userTasks.rawValue
        let userIdQueryItem = URLQueryItem(name: "userId", value: String(userId ?? 0))
        let queryItems = [userIdQueryItem]
        components.queryItems = queryItems
        guard let queryURL = components.url else { return nil }
            return queryURL

    }
}
