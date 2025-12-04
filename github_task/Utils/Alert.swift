//
//  Alert.swift
//  github_task
//
//  Created by Yash Rathod on 12/4/25.
//
import UIKit
import Foundation

func showAlert(on vc: UIViewController, title: String, message: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    vc.present(alert, animated: true)
    
}
