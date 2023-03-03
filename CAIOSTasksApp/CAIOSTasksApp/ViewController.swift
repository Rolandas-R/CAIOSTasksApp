//
//  ViewController.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-02-26.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var enterUserNameField: UITextField!
    @IBOutlet weak var enterPasswordField: UITextField!
    @IBOutlet weak var enterCredentialsButton: UIButton!
    @IBOutlet weak var navigationalTextLabel: UILabel!
    
    let swagger = SwaggerAPI()
    
    var tasks: [Task] = []
    
    let userManager = UserManager()
    
    var users: [User] = []
    

    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
                navigationalTextLabel.isUserInteractionEnabled = true
                navigationalTextLabel.addGestureRecognizer(tap)
        // INIT
    }

    @IBAction func enterCredentialsButtonTapped(_ sender: Any) {
        navigationalTextLabel.text = "Already registered? Login!"
        

                    
    }
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        print("Label tapped")
        enterCredentialsButton.titleLabel?.text = "Register"
        navigationalTextLabel.text = "Have no username? Register!"
        
//        swagger.deleteUser(userId: user22.userId ?? 0)
        
//        swagger.fetchUserTasks(userId: user22.userId ?? 0) { result in
//            switch result {
//
//            case .success(let results):
//                self.tasks.append(contentsOf: results)
//
//                for task in self.tasks {
//                    print("Id: \(task.id), title: \(task.title), description: \(task.description), estimateMinutes: \(task.estimateMinutes), loggedTime: \(task.loggedTime), isDone: \(task.isDone), assigneeInfo: \(task.assigneeInfo.id) - \(task.assigneeInfo.username)")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        let newTask = TasksManager.NewTaskRegistrationRequest(title: "Pavadinimas44", description: "Ketvirtas task", estimateMinutes: 20, assigneeId: user22.userId ?? 0)
        swagger.createNewTask(newTask: newTask) { respData in
            guard let respData = respData, let taskResponse = try? JSONDecoder().decode(TasksManager.NewTaskResponce.self, from: respData) else { return }
            let task = Task(id: taskResponse.id, title: newTask.title, description: newTask.description, estimateMinutes: newTask.estimateMinutes, assigneeInfo: Assignee(id: user22.userId!, username: user22.username!), loggedTime: newTask.estimateMinutes, isDone: false)
            self.tasks.append(task)
            print (String (data: respData, encoding: .utf8) ?? "nil")
        }
        
        
        
    }
    
}

