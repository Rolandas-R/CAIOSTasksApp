//
//  SwaggerAPI.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-01.
//

import Foundation

class SwaggerAPI {
    
    enum APIErorr: Error {
        case badRequest(errorMessage: String?)
        case notFound
        case fetchFail
        case parsingFail
    }
    
    //    struct ApiData<T: Decodable>: Decodable {
    //        let results: [T]
    //    }
    //
    //    private(set) var task: URLSessionDataTask?
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    
    private func postRequest(url: URL, body: Data?, callback: @escaping (Result<Data, APIErorr>) -> Void){
        var request = URLRequest (url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue ("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                callback(.failure(.fetchFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                callback(.failure(.fetchFail))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                callback(.success(data))
            case 404:
                callback(.failure(.notFound))
            case 400:
                callback(.failure(.badRequest(errorMessage: String(data: data, encoding: .utf8))))
            default:
                callback(.failure(.fetchFail))
            }
        }.resume()
    }
    
    
    
    private func performRequest(url: URL?, callback: @escaping (Result<Data, APIErorr>) -> Void) {
        
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                callback(.failure(.fetchFail))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                callback(.failure(.fetchFail))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                callback(.success(data))
            case 400:
                callback(.failure(.badRequest(errorMessage: String(data: data, encoding: .utf8))))
            case 404:
                callback(.failure(.notFound))
            default:
                callback(.failure(.fetchFail))
            }
        }.resume()
    }
    
    func registerUser(user: UserManager.AuthentificateRequest, completion: @escaping (Data?) -> Void) {
        let url = Constants.getURL(for: .userEndpoint, subEndpoint: .register)
        let registerRequestParams = user
        
        let bodyData = try! encoder.encode(registerRequestParams)
        
        postRequest(url: url!, body: bodyData) { [weak self] response in
            guard self != nil else { return }
            switch response {
            case .success(let data):
                print("registering success")
                completion(data)
            case .failure(let error):
                switch error {
                case .fetchFail:
                    print("unknown error")
                case .notFound:
                    print("Not found")
                case .badRequest(let errorMessage):
                    print("Bad request:")
                    print(errorMessage ?? "Bad request")
                case .parsingFail:
                    print("parsing failed")
                }
                completion(nil)
            }
        }
    }
    
    func deleteRequest (url: URL?, completion: @escaping (Data?) -> Void) {
        
        var request = URLRequest (url: url!)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                switch httpResponse.statusCode {
                case 200:
                    print("Success: deleted")
                case 400:
                    print("Bad request")
                case 404:
                    print("Already deleted")
                default:
                    print("Unknown generic error")
                }
                completion (data)
                return
            }
        }.resume()
    }
    
    func deleteUser(userId: Int) {
        guard let url = Constants.getURL(for: .userEndpoint, id: userId) else { return }
        
        deleteRequest(url: url){ responseData in
            guard let responseData = responseData else { return }
            print (String (data: responseData, encoding: .utf8)!)
        }
    }
    
    func fetchUserTasks(userId: Int, completion: @escaping (Result<[Task], APIErorr>) -> Void) {
        
        let id = userId
        guard let queryURL = Constants.buildGetUserTasksURL(userId: id) else { return }
        print(queryURL)
        performRequest(url: queryURL) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(Tasks.self, from: data)
                    completion(.success(parsedData.tasks))
                    
                } catch {
                    completion(.failure(.parsingFail))
                }
            case .failure(let error):
                switch error {
                case .fetchFail:
                    print("unknown error")
                case .notFound:
                    print("Not found")
                case .badRequest(let errorMessage):
                    print("Bad request:")
                    print(errorMessage ?? "Bad request")
                case .parsingFail:
                    print("parsing failed")
                }
                //            completion(.failure(.parsingFail))
            }
        }
    }
    
    func createNewTask(newTask: TasksManager.NewTaskRegistrationRequest, completion: @escaping (Data?) -> Void) {
        let newTaskURL = Constants.getURL(for: .taskEndpoint)!
        
        let postNewTaskRequest = newTask
        let taskData = try! JSONEncoder().encode (postNewTaskRequest)
        
        postRequest(url: newTaskURL, body: taskData) { [weak self] response in
            guard self != nil else { return }
            switch response {
            case .success(let data):
                print("New Task was created")
                completion(data)
            case .failure(let error):
                switch error {
                case .fetchFail:
                    print("unknown error")
                case .notFound:
                    print("Not found")
                case .badRequest(let errorMessage):
                    print("Bad request:")
                    print(errorMessage ?? "Bad request")
                case .parsingFail:
                    print("parsing failed")
                }
                completion(nil)
            }
        }
    }
}

    


