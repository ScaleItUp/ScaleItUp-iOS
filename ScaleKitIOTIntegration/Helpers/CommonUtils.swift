//
//  CommonUtils.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

class CommonUtils: NSObject {
    
    static let sharedInstance = CommonUtils()
    
    private override init() {
        super.init()
    }
    
    /// This function will return a custom server error.
    ///
    /// - Returns: ServerError object.
    func defaultError() -> ServerError {
        let error = NSError(domain: StringConstants.domain, code: 0, userInfo: nil)
        let customError = ServerError(err: error)
        return customError
    }
    
    /// This function will return a custom server error with the passed `errorMessage`.
    ///
    /// - Parameter errorMessage: Error Message to be shown to the user
    /// - Returns: ServerError object.
    func signInError(_ errorMessage: String) -> ServerError {
        let error = NSError(domain: StringConstants.domain, code: 1, userInfo: nil)
        let customError = ServerError(err: error, customErrorMessage: errorMessage)
        return customError
    }
}
