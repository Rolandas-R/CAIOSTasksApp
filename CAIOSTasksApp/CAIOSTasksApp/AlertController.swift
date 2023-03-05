//
//  UIAlertController.swift
//  CAIOSTasksApp
//
//  Created by reromac on 2023-03-05.
//


import UIKit

extension UIAlertController {
    
    
    func showAlert(_ title: String, message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func showError(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Oops, there' an error!", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
