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
    @IBOutlet weak var navigationalTextLabel: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // INIT
    }

    @IBAction func enterCredentialsButtonTapped(_ sender: Any) {
        navigationalTextLabel.text = "You're tapped to register button"
    }
    
}

