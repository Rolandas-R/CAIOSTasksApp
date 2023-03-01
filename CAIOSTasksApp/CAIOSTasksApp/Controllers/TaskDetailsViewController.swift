//
//  TaskDetailsViewController.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-02-26.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    @IBOutlet weak var taskDetailsTableView: UITableView!
    
    let cellDescriptions: [String] = ["Title", "Description", "Estimated minutes", "Logged time", "Assignee"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTaskDetailsTableView()

        // Do any additional setup after loading the view.
    }
    
    private func setupTaskDetailsTableView() {
        taskDetailsTableView.dataSource = self
        taskDetailsTableView.delegate = self
    }
    
    
    @IBAction func updateTaskDetailButtonTapped(_ sender: Any) {
        print("Update Task Detail Button Tapped")
    }
    
    
    @IBAction func cellStepperTapped(_ sender: Any) {
        print("Logged time stepper in task description prototype cell tapped")
    }
}




extension TaskDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTaskDetailCell", for: indexPath)
        cell.textLabel?.text = cellDescriptions[indexPath.row]
        if indexPath.row == 3 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "mainTaskDetailCellWithStepper", for: indexPath)
            cell2.textLabel?.text = cellDescriptions[indexPath.row]
            return cell2
        } else {
            return cell
        }
        
        
    }
}
    
extension TaskDetailsViewController: UITableViewDelegate {
        
    }

