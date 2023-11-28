//
//  ServerError.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

struct ServerError {
    
    var error:NSError?
    var errorCode: Int
    var errorMessage: String?

    /// This is the init for Server Error
    ///
    /// - Parameters:
    ///     - err: NSError Object
    ///     - customErrorMessage: Error Message
    init(err:NSError, customErrorMessage: String? = nil) {
        self.error = err
        self.errorCode = err.code
        self.errorMessage = err.localizedDescription
        if let customError = customErrorMessage {
            self.errorMessage = customError
        } else {
            self.setUserMessage()
        }
    }
    
    /// This function will set the custom error message
    mutating func setUserMessage() {
        switch self.errorCode {
            case 0:
                self.errorMessage = StringConstants.defaultError
            case -1009:
                self.errorMessage = StringConstants.internetError
            default:
                self.errorMessage = StringConstants.defaultError
        }
    }
    
}
