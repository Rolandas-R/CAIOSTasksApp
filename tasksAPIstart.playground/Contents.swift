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

let kUserId = 49


let taskURL = "http://134.122.94.77/api/Task/userTasks"
let userURL = "http://134.122.94.77/api/User"

//func buildUserQueryURL() -> URL? {
//    if let url = URL(string: userURL) {
//        return url
//    }
//    return nil
//}

func postRequest (url: URL, body: Data?, completion: @escaping (Data?) -> Void) {
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
    if let url = URL(string: taskURL) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let userIdQueryItem = URLQueryItem(name: "userId", value: String(kUserId))
        let queryItems = [userIdQueryItem]
        components?.queryItems = queryItems
        guard let queryURL = components?.url else { return nil }
        print(queryURL)
        return queryURL
    }
    return nil
}

buildQueryURL()


// URL'ai:
//let loginURL = URL(string: "http://134.122.94.77/api/user/login")!
//let registerURL = URL(string: "http://134.122.94.77/api/User/register")!
////let deleteUserURL = URL(string: "http://134.122.94.77/api/User/")!
//let getUserTasksURL = URL(string: "http://134.122.94.77/api/Task/userTasks")

// Requestai:

// register
//let registerUserRequest = UserRegisterRequest(username: "DDDD", password: "DDDD")
//let registerData = try! JSONEncoder().encode (registerUserRequest)
//
//postRequest(url: registerURL, body: registerData) { responseData in
//        guard let responseData = responseData else { return }
//        print (String (data: responseData, encoding: .utf8) ?? "nil")
//}

// login
//let loginUserRequest = UserLoginRequest(username: "DDDD", password: "DDDD")
//let loginData = try! JSONEncoder().encode (loginUserRequest)
//
//postRequest(url: loginURL, body: loginData) { responseData in
//        guard let responseData = responseData else { return }
//        print (String (data: responseData, encoding: .utf8) ?? "nil")
//}

// delete

//var deletingUser = UserDeleteRequest(id: 48)
//let url = buildDeleteUserURL(baseURL: userURL, id: deletingUser.id)
//deleteRequest(url: url!) { responseData in
//    guard let responseData = responseData else { return }
//    print (String (data: responseData, encoding: .utf8)!)
//}





