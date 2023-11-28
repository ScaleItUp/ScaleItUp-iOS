//
//  ActivityIndicator.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import UIKit

class ActivityIndicator: UIView {
    
    static let sharedInstance = ActivityIndicator()
    
    private var activityView: UIActivityIndicatorView?
    
    /// This function will show the activity indicator
    ///
    /// - Parameter superview: UIViewController on top of which we have to show the activity indicator.
    func showActivityIndicator(_ superView: UIViewController) {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = superView.view.center
        superView.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    /// This function will hide the activity indicator.
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}
