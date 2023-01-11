//
//  UIViewController+alert.swift
//  hangmanGame
//
//  Created by Daria Sechko on 11.01.23.
//

import Foundation

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
