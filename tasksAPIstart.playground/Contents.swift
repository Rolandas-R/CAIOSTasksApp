import Foundation

struct UserLoginRequest: Codable {
    let username: String
    let password: String
}

struct UserRegisterRequest: Codable {
    let username: String
    let password: String
}

struct UserDeleteRequest: Codable {
    let id: Int
}

struct TaskDeleteRequest: Codable {
    let id: Int
}

struct Task: Codable {
    let id: Int?
    let title: String
    let description: String
    let estimateMinutes: Int
    let assigneeId: Int?
    var loggedTime: Int?
    var isDone: Bool?
}

enum NetworkError: Error {
    case badRequest(errorMessage: String?)
    case notFound
    case unknown
}


private var dataTask: URLSessionDataTask?

let kUserId = 101


let userTasksURL = "http://134.122.94.77/api/Task/userTasks"
let userURL = "http://134.122.94.77/api/User"
let taskURL =  URL(string:"http://134.122.94.77/api/Task")!



func postRequest (url: URL, body: Data?, completion: @escaping (Data) -> Void) {
    var request = URLRequest (url: url)
    request.httpMethod = "POST"
    request.httpBody = body
    request.addValue ("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error ?? "Unknown error")
            return
        }

            completion (data)

    }.resume()
}


func buildDeleteUserURL(baseURL: String, id: Int) -> URL? {
    let baseURL = userURL
    return URL(string: "\(baseURL)/\(id)")
}


func deleteRequest (url: URL, completion: @escaping (Data?) -> Void) {
    
    var request = URLRequest (url: url)
    request.httpMethod = "DELETE"
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error ?? "Unknown error")
            return
        }
        if let httpResponse = response as? HTTPURLResponse {
            print("statusCode: \(httpResponse.statusCode)")
        }
        completion (data)
        return
    }.resume()
}

func buildQueryURL() -> URL? {
    if let url = URL(string: userTasksURL) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let userIdQueryItem = URLQueryItem(name: "userId", value: String(kUserId))
        let queryItems = [userIdQueryItem]
        components?.queryItems = queryItems
        guard let queryURL = components?.url else { return nil }
        return queryURL
    }
    return nil
}
buildQueryURL()

func buildURLWithId(baseURL: URL?, id: Int) -> URL? {
   let baseURL = taskURL
   return URL(string: "\(baseURL)/\(id)")
}


// URL'ai:
let loginURL = URL(string: "http://134.122.94.77/api/user/login")!
let registerURL = URL(string: "http://134.122.94.77/api/User/register")!
let deleteUserURL = URL(string: "http://134.122.94.77/api/User/")!
let newTaskURL = URL(string: "http://134.122.94.77/api/Task")!


// MARK: - Requestai:

// MARK: REGISTER USER

//let useris = UserRegisterRequest(username: "useriokas", password: "kazkas")
//
//let registerUserRequest = useris
//let registerData = try! JSONEncoder().encode (registerUserRequest)
//
//postRequest(url: registerURL, body: registerData) { responseData in
//        guard let responseData = responseData else { return }
//        print (String (data: responseData, encoding: .utf8) ?? "nil")
//}


// MARK: LOGIN USER

//let loginUserRequest = UserLoginRequest(username: "dd", password: "bb")
//let loginData = try! JSONEncoder().encode (loginUserRequest)
//
//postRequest(url: loginURL, body: loginData) { responseData in
//
//        let datas =  (String (data: responseData, encoding: .utf8) ?? "nil")
//    let result = try! JSONDecoder().decode(datas, from: datas)
//    print(result)
//}


// MARK: DELETE USER
/*

var deletingUser = UserDeleteRequest(id: 49)
let url = buildDeleteUserURL(baseURL: userURL, id: deletingUser.id)
deleteRequest(url: url!) { responseData in
    guard let responseData = responseData else { return }
    print (String (data: responseData, encoding: .utf8)!)
}
*/

// MARK: FETCH ALL USER TASKS
/*
public func fetchUserTasks(completion: @escaping (Data?) -> Void) {
//    dataTask?.cancel()

    if let queryURL = buildQueryURL() {
        dataTask = URLSession.shared.dataTask(with: queryURL) {
            data,
            response,
            error in
            guard let data else {
                completion(nil)
                return
            }
            return completion(data)
        }
    }
    dataTask?.resume()
}

fetchUserTasks { data in
    DispatchQueue.main.async {
        let result = try? JSONDecoder().decode(Data.self, from: data!)
        print (String (data: data!, encoding: .utf8)!)
    }
}
 */
   

// MARK: POST new task
/*
func postNewTask (url: URL, body: Data?, completion: @escaping (Data?) -> Void) {

    var request = URLRequest (url: url)
    request.httpMethod = "POST"
    request.httpBody = body
    request.addValue ("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error ?? "Unknown error")
            return
        }
        if let httpResponse = response as? HTTPURLResponse {
            print("statusCode: \(httpResponse.statusCode)")
        }
        completion (data)
        return
    }.resume()
}

let postNewTaskRequest = Task(id: nil, title: "Boobs", description: "Fine", estimateMinutes: 10, assigneeId: kUserId)
let taskData = try! JSONEncoder().encode (postNewTaskRequest)

postNewTask(url: newTaskURL, body: taskData) { data in
        guard let data = data else { return }
    DispatchQueue.main.async {
        let result = try? JSONDecoder().decode(Data.self, from: data)
        print (String (data: data, encoding: .utf8)!)
    }
}
*/

// MARK: GET Task with id
/*
 func buildURLWithId(baseURL: URL?, id: Int) -> URL? {
    let baseURL = taskURL
    return URL(string: "\(baseURL)/\(id)")
}

func fetchTask(completion: @escaping (Data?) -> Void) {
//    dataTask?.cancel()

 if let queryURL = buildURLWithId(baseURL: taskURL, id: 111) {
        dataTask = URLSession.shared.dataTask(with: queryURL) { data, response, error in
            guard let data else {
                completion(nil)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                return completion(data)
            }
        }
    }
    dataTask?.resume()
}

fetchTask { data in
    DispatchQueue.main.async {
        let result = try? JSONDecoder().decode(Data.self, from: data!)
        print (String (data: data!, encoding: .utf8)!)

    }
}
 */


// MARK: EDIT TASK (PUT):
/*
func editTask(url: URL, body: Data?, completion: @escaping (Data?) -> Void) {
    var request = URLRequest (url: taskURL)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "PUT"
    request.httpBody = body
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print(String(data: data, encoding: .utf8)!)
    }
    task.resume()
}

let editTaskRequest = Task(id: 111, title: "UzduotisRaaa2", description: "aprasymasaaa2", estimateMinutes: 10, assigneeId: 101, loggedTime: 10, isDone: true)
let editTaskData = try! JSONEncoder().encode (editTaskRequest)

editTask(url: taskURL, body: editTaskData) { data in
        guard let data = data else { return }
    DispatchQueue.main.async {
        let result = try? JSONDecoder().decode(Data.self, from: data)
        print (String (data: data, encoding: .utf8)!)
    }
}
 */


// MARK: DELETE TASK
/*
var deletingtask = TaskDeleteRequest(id: 111)
let url = buildURLWithId(baseURL: taskURL, id: deletingtask.id)
deleteRequest(url: url!) { responseData in
    guard let responseData = responseData else { return }
    print (String (data: responseData, encoding: .utf8)!)
}
 */


            

            
            
           
        


    





