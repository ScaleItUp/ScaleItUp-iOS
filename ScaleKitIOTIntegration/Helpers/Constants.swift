//
//  Constants.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

public enum FetchCase {
    case containerWeight, singleItemWeight, totalItemWeight
}

struct StringConstants {

    static let domain = "com.example.ScaleKitIOTIntegration"
    static let defaultError = "Something went wrong!"
    static let internetError = "No Internet! Please check your connection."
    static let okTitle = "OK"
    static let defaultErrorHeader = "Error"
}

struct NetworkConstants {
    
    static let getWeightAPI = "https://scalekit-backend.onrender.com/api/get-weight"
    static let sendWeightAPI = "https://scalekit-backend.onrender.com/api/send-weight"
}
