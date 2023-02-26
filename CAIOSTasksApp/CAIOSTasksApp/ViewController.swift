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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
}

