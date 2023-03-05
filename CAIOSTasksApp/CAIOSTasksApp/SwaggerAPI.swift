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
        case notFound(errorMessage: String?)
        case fetchFail
        case parsingFail
        case methodNotAllowed(errorMessage: String?)
        
    }
    

    static let shared = SwaggerAPI()
//    private(set) var dataTask: URLSessionDataTask?
    private init() { }
    
    
//    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    
    // POST
    
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
                callback(.failure(.notFound(errorMessage: String(data: data, encoding: .utf8))))
            case 400:
                callback(.failure(.badRequest(errorMessage: String(data: data, encoding: .utf8))))
            default:
                callback(.failure(.fetchFail))
            }
        }.resume()
    }
    
    
    // GET
    public func getRequest(url: URL?, callback: @escaping (Result<Data, APIErorr>) -> Void) {
        
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
                callback(.failure(.notFound(errorMessage: String(data: data, encoding: .utf8))))
            default:
                callback(.failure(.fetchFail))
            }
        }.resume()
    }
    
    // DELETE
    
    public func deleteRequest (url: URL?, completion: @escaping (Data?) -> Void) {
        
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
    
    // PUT
    
    private func putRequest(url: URL, body: Data?, callback: @escaping (Result<Data, APIErorr>) -> Void){
        var request = URLRequest (url: url)
        request.httpMethod = "PUT"
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
                callback(.failure(.notFound(errorMessage: String(data: data, encoding: .utf8))))
            case 405:
                callback(.failure(.methodNotAllowed(errorMessage: String(data: data, encoding: .utf8))))
            case 400:
                callback(.failure(.badRequest(errorMessage: String(data: data, encoding: .utf8))))
            default:
                callback(.failure(.fetchFail))
            }
        }.resume()
    }
    
    
    
    // Darbines f-jos
    
    func registerUser(user: UserManager.AuthentificateRequest, completion: @escaping (Result<User, Error>) -> Void) {
        

     
        let url = Constants.getURL(for: .userEndpoint, urlSuffix: .register )
        let registerRequestParams = user
        
        let bodyData = try! JSONEncoder().encode(registerRequestParams)
        
        postRequest(url: url!, body: bodyData) { [weak self] response in
            guard self != nil else { return }
            switch response {
            case .success(let responseData):
                guard let userResponse = try? JSONDecoder().decode(UserManager.UserResponse.self, from: responseData) else { return }
                let user = User(username: user.username, password: user.password, userId: userResponse.userId)
                user.userId = userResponse.userId
                print("registering success")
                completion(.success(user))
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
                case .methodNotAllowed:
                    print("wrong method")
                }
                completion(.failure(error))
            }
        }
    }
   
    func deleteUser(userId: Int) {
        guard let url = Constants.getURL(for: .userEndpoint, id: userId) else { return }
        
        deleteRequest(url: url){ responseData in
            guard let responseData = responseData else { return }
            print (String (data: responseData, encoding: .utf8)!)
            UserManager.users.removeLast()
        }
    }
    
    func fetchUserTasks(userId: Int, completion: @escaping (Result<[Task], APIErorr>) -> Void) {
        
        let id = userId
        guard let queryURL = Constants.buildURLWithParams(userId: id) else { return }
        print(queryURL)
        getRequest(url: queryURL) { [weak self] result in
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
                case .methodNotAllowed:
                    print("wrong method")
                }
                //            completion(.failure(.parsingFail))
            }
        }
    }
    
    func fetchTask (taskId: Int, completion: @escaping (Result<Task, APIErorr>) -> Void) {

        guard let queryURL = Constants.getURL(for: .taskEndpoint, id: taskId) else { return }
        print(queryURL)
        getRequest(url: queryURL) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(Task.self, from: data)
                    completion(.success(parsedData))
                    
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
                case .methodNotAllowed:
                    print("wrong method")
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
                case .methodNotAllowed:
                    print("wrong method")
                }
                completion(nil)
            }
        }
    }
    
    func editTask(taskDetails: TasksManager.TaskEditRequest, completion: @escaping (Data?) -> Void) {
        let editTaskURL = Constants.getURL(for: .taskEndpoint)!
        
        let postEditTaskRequest = taskDetails
        
        let taskData = try! JSONEncoder().encode (postEditTaskRequest)
        
        putRequest(url: editTaskURL, body: taskData) { [weak self] response in
            guard self != nil else { return }
            switch response {
            case .success(let data):
                print("Task was edited")
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
                case .methodNotAllowed:
                    print("wrong method")
                }
                completion(nil)
            }
        }
    }
    

}

    


