//
//  UserDetailsViewController.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-02-26.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    let swagger = SwaggerAPI.shared
    
    var currentUser = UserManager.users.last
 
    
    @IBOutlet weak var presentUserNameTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for user in UserManager.users {
            print("\(user.username) and \(user.password) plus \(user.userId)")
        }
        
        presentUserNameTextLabel.text = currentUser?.username
       
    }
    
    
    @IBAction func deleteUserTapped(_ sender: Any) {
        swagger.deleteUser(userId: currentUser?.userId ?? 0)
        dismiss(animated: true, completion: nil)
       
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /* MARK: tasko su id fetchinimas ir (?) editinimas:
     var tasks: [Task] = []
     let editingTaskId = TasksManager.TaskRequest(id: 185)
     
     let editingTask = TasksManager.TaskEditRequest(id: editingTaskId.id, title: "kazkoksgalutinai?", description: "Tikiuosi PUT veikia", estimateMinutes: 10, assigneeId: user22.userId ?? 0, loggedTime: 10, isDone: true)
     
     swagger.editTask(taskDetails: editingTask) { respData in
         guard let respData = respData else { return }
         print (String (data: respData, encoding: .utf8) ?? "nil")
         
         self.swagger.fetchUserTasks(userId: user22.userId ?? 0) { result in
             switch result {
                 
             case .success(let results):
                 self.tasks.append(contentsOf: results)
                 print("after \(self.tasks.count)")
                 
                 for task in self.tasks {
                     print("Id: \(task.id), title: \(task.title), description: \(task.description), estimateMinutes: \(task.estimateMinutes), loggedTime: \(task.loggedTime), isDone: \(task.isDone), assigneeInfo: \(task.assigneeInfo.id) - \(task.assigneeInfo.username)")
                 }
             case .failure(let error):
                 print(error.localizedDescription)
             }
         }
     }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
