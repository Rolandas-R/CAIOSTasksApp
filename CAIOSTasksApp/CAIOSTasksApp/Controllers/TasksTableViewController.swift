//
//  TasksTableViewController.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-02-26.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    let swagger = SwaggerAPI.shared
//    var user = UserManager.users.last
    var newTask: TasksManager.NewTaskRegistrationRequest?
    var user = user22
    
    private var tableData: [Task]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchAllTasks()
        
        
        

    }
    
    func fetchAllTasks() {
        swagger.fetchUserTasks(userId: user.userId ?? 0) { task in
            guard self.user.userId != nil else { return }
            
            switch task {
                
            case .success(let tasks):
                self.tableData = tasks
                
            case .failure(let error):
                assert(false, "Fetch error!")
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func newTaskDetails() {
        let alertController = UIAlertController(title: "Enter new task details", message: "Create new task", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Task title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Task description"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Task Estimate Minutes"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Assignee ID"
        }
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            
            
            guard let textFields = alertController.textFields else { return }
            if let newTaskTitle = textFields[0].text,
               let newTaskDescription = textFields[1].text,
               let newTaskEstimateMinutes = textFields[2].text,
               let newTaskAsigneeId = textFields[3].text {
                self.newTask = TasksManager.NewTaskRegistrationRequest(title: newTaskTitle, description: newTaskDescription, estimateMinutes: Int(newTaskEstimateMinutes)!, assigneeId: Int(newTaskAsigneeId)!)
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)

    }
    @IBAction func createNewTaskButtonTapped(_ sender: Any) {
        newTaskDetails()

//
        let newTask = TasksManager.NewTaskRegistrationRequest(title: newTask?.title ?? "Kazkoks pavadinimas nes nill", description: newTask?.description ?? "kazkoks aprasymas nes nill", estimateMinutes: newTask?.estimateMinutes ?? 0, assigneeId: user.userId ?? 0)
        
        swagger.createNewTask(newTask: newTask) { respData in
            guard let respData = respData, let taskResponse = try? JSONDecoder().decode(TasksManager.TaskRequest.self, from: respData) else { return }
            let task = Task(id: taskResponse.id, title: self.newTask!.title, description: self.newTask!.description, estimateMinutes: self.newTask!.estimateMinutes, assigneeInfo: Assignee(id: self.newTask!.assigneeId, username: self.user.username ?? ""), loggedTime: self.newTask!.estimateMinutes, isDone: false)
            print (String (data: respData, encoding: .utf8) ?? "nil")
            print(taskResponse.id)
            DispatchQueue.main.async { [weak self] in
                self?.fetchAllTasks()
//                self?.tableData.reloadData()
                            }
//            self.fetchAllTasks()
            
        }
        

    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath) as UITableViewCell
        
        guard (tableData?[indexPath.row]) != nil else { return cell }
        cell.textLabel?.text = tableData?[indexPath.row].title
        cell.detailTextLabel?.text = tableData?[indexPath.row].description
        cell.textLabel?.font = .systemFont(ofSize: 20)
        cell.detailTextLabel?.font = .systemFont(ofSize: 18)
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskId = (tableData?[indexPath.row].id)!
                if editingStyle == .delete {
                    tableData?.remove(at: indexPath.row)
                    swagger.deleteTask(taskId: taskId)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
            
        } else if editingStyle == .insert {
            return
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //        print("before \(tasks.count)")
    //
    //        let newTask = TasksManager.NewTaskRegistrationRequest(title: "Sestadienis4", description: "Pavadinimas4", estimateMinutes: 20, assigneeId: user22.userId ?? 0)
    //
    //        swagger.createNewTask(newTask: newTask) { respData in
    //            guard let respData = respData, let taskResponse = try? JSONDecoder().decode(TasksManager.TaskRequest.self, from: respData) else { return }
    //            let task = Task(id: taskResponse.id, title: newTask.title, description: newTask.description, estimateMinutes: newTask.estimateMinutes, assigneeInfo: Assignee(id: user22.userId!, username: user22.username!), loggedTime: newTask.estimateMinutes, isDone: false)
    //            self.tasks.append(task)
    //            print (String (data: respData, encoding: .utf8) ?? "nil")
    //            print(String (taskResponse.id))
    //            print("after \(self.tasks.count)")
    //        }
            

}
