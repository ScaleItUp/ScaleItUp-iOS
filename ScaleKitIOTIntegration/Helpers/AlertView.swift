//
//  AlertView.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import UIKit

class AlertView: UIViewController {
    static let sharedInstance = AlertView()
    
    private var window = UIApplication.shared.windows.first { $0.isKeyWindow }
    
    /// This function will show alert.
    ///
    /// - Parameters:
    ///     - header: Header of the alert
    ///     - message: Body of the alert
    ///     - actionTitle: Button Text of the alert
    func showAlert(header: String, message: String, actionTitle: String) {
        
        var topViewController = self.window?.rootViewController
        while topViewController?.presentedViewController != nil
        {
            topViewController = topViewController?.presentedViewController
        }
        
        let alertController = UIAlertController(title: header, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        
        topViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
}
