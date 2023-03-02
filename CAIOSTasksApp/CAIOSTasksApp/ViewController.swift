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
    
//    var tasks: [Task] = []
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = Constants.getURL(for: .userEndpoint, id: 101)
//        let url2 = Constants.getURL(for: .taskEndpoint, id: 104)
//        print(url!)
//        print(url2!)
//        let url3 = Constants.getURL(for: .userEndpoint, subEndpoint: .register)
//        print(url3!)
//        guard let url4 = Constants.buildGetUserTasksURL() else { return }
//        print(url4)
//        
//        swagger.registerUser(user: user22) { responseData in
//            struct UserResponse: Decodable {
//                let userId: Int
//            }
//            guard let responseData = responseData, let userResponse = try? JSONDecoder().decode(UserResponse.self, from: responseData) else { return }
//            user22.userId = userResponse.userId
//            print (String (data: responseData, encoding: .utf8) ?? "nil")
//            print(user22.userId)
//            
//        }

        
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
        swagger.fetchUserTasks(userId: user22.userId ?? 0) { result in
            switch result {

            case .success(let results):
                print(results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
}

