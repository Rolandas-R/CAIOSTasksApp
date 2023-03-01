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
       let url = Constants.getURL(for: .userEndpoint, id: 101)
        let url2 = Constants.getURL(for: .taskEndpoint, id: 104)
        print(url)
        print(url2)
        let url3 = Constants.getURL(for: .userEndpoint, subEndpoint: .register)
        print(url3)
        guard let url4 = Constants.buildGetUserTasksURL() else { return }
        print(url4)
        
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

