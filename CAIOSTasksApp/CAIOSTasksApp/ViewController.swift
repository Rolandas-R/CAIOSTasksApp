//
//  ViewController.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-02-26.
//

import UIKit

class ViewController: UIViewController {
    
    enum State {
        case register
        case login
    }
    
    
    @IBOutlet weak var enterUserNameField: UITextField!
    @IBOutlet weak var enterPasswordField: UITextField!
    @IBOutlet weak var enterCredentialsButton: UIButton!
    @IBOutlet weak var navigationalTextLabel: UILabel!
    
    
    let swagger = SwaggerAPI.shared
    
    let userManager = UserManager()
    
    let taskManager = TasksManager()
    var currentUser = User?.self
    
//    var currentUser = UserManager.users.last
    
    var currentState: State = .register
    

    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.labelTapFunction))
        navigationalTextLabel.isUserInteractionEnabled = true
        navigationalTextLabel.addGestureRecognizer(tap)
    }
    
    
    private func authenticateUser() {
        
        let username = enterUserNameField.text ?? ""
        let password = enterPasswordField.text ?? ""
        guard username.count > 1 && password.count > 1 else {
            print("Empty fields")
            return
        }
        
        let authUser = UserManager.AuthentificateRequest(username: username, password: password)
        swagger.registerUser(user: authUser) { responseData in
            DispatchQueue.main.async { [weak self] in
                guard self != nil else { return }
                switch responseData {
                case .success(let User):
                    let currentUser = User
                    print("User: \(currentUser.userId ?? 0), \(currentUser.username ?? ""), \(currentUser.password ?? "")")
                    UserManager.users.append(currentUser)

                    self!.goToNextVC(user: currentUser)
                case .failure(let APIError):
                    print("Error: \(APIError)")
                }
                
            }
            
        }
    }
    
    
    
    private func goToNextVC (user: User) {
        print("opens tasks view controller")
        let tableViewController = TasksTableViewController()
        tableViewController.user = user
        present(tableViewController, animated: false)
    }
        


    @IBAction func enterCredentialsButtonTapped(_ sender: Any) {
        authenticateUser()

        navigationalTextLabel.text = "Already registered? Login!"
        }

    
    @IBAction func labelTapFunction(sender: UITapGestureRecognizer) {
        authenticateUser()

        enterCredentialsButton.titleLabel?.text = "Register"
        navigationalTextLabel.text = "Have no username? Register!"
        
        
        
        
        
        
        
        
//        guard let responseData = responseData, let userResponse = try? JSONDecoder().decode(UserManager.UserResponse.self, from: responseData) else { return }
//        let user = User(username: authUser.username, password: authUser.password, userId: userResponse.userId)
//        user.userId = userResponse.userId
//        print (String (data: responseData, encoding: .utf8) ?? "nil")
//            print("user: \(user.username!), passw: \(user.password!), userId: \(user.userId!)")
        
        
        
/*
        let authUser = UserManager.AuthentificateRequest(username: "Marijans", password: "Latvis")
        swagger.registerUser(user:authUser) { responseData in

            guard let responseData = responseData, let userResponse = try? JSONDecoder().decode(UserManager.UserResponse.self, from: responseData) else { return }
            var user = User(username: authUser.username, password: authUser.password, userId: userResponse.userId)
            user.userId = userResponse.userId
            self.users.append(user)
            print (String (data: responseData, encoding: .utf8) ?? "nil")
            for user in self.users {
                print("user: \(user.username!), passw: \(user.password!), userId: \(user.userId!)")
            }

        }
 */
        
        

        
        
        
        
        
//        swagger.fetchUserTasks(userId: user22.userId ?? 0) { result in
//            switch result {
//
//            case .success(let results):
//                self.tasks.append(contentsOf: results)
//                print("after \(self.tasks.count)")
//
//
//                for task in self.tasks {
//                    print("Id: \(task.id), title: \(task.title), description: \(task.description), estimateMinutes: \(task.estimateMinutes), loggedTime: \(task.loggedTime), isDone: \(task.isDone), assigneeInfo: \(task.assigneeInfo.id) - \(task.assigneeInfo.username)")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
  
//        let newTask = TasksManager.NewTaskRegistrationRequest(title: "Sestadienis2", description: "Pavadinimas2LastBeforeLast", estimateMinutes: 20, assigneeId: user22.userId ?? 0)
//        swagger.createNewTask(newTask: newTask) { respData in
//            guard let respData = respData, let taskResponse = try? JSONDecoder().decode(TasksManager.TaskRequest.self, from: respData) else { return }
//            let task = Task(id: taskResponse.id, title: newTask.title, description: newTask.description, estimateMinutes: newTask.estimateMinutes, assigneeInfo: Assignee(id: user22.userId!, username: user22.username!), loggedTime: newTask.estimateMinutes, isDone: false)
//            self.tasks.append(task)
//            print (String (data: respData, encoding: .utf8) ?? "nil")
//        }
 
    }
    
    @IBAction func wtf(_ sender: Any) {

    }
}

