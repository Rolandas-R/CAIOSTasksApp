//
//  TaskDetailsViewController.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-02-26.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    @IBOutlet weak var taskDetailsTableView: UITableView!
    
    
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
    
}




extension TaskDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskDetailCell", for: indexPath)
        return cell
    }
    
    
}

extension TaskDetailsViewController: UITableViewDelegate {
    
}
