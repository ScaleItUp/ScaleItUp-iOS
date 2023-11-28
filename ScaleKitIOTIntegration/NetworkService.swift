//
//  NetworkService.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

class NetworkService {
        
    /// This is the GET call through URL Session
    ///
    /// - Parameters:
    ///     - withBaseURL: the base url of the API call
    ///     - completion: callback with Data Object and ServerError Object
    func get(withBaseURL: String,
             completion: @escaping (_ result: Data?, _ error: ServerError?) -> Void) {
        
        if let components = URLComponents(string: withBaseURL) {
            if let url2 = components.url {
                let request  = URLRequest(url: url2)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    DispatchQueue.main.async {
                        if error == nil {
                            completion(data, nil)
                        } else {
                            if let err = error as NSError? {
                                let error = ServerError(err: err)
                                completion(nil, error)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    /// This is the POST call through URL Session
    ///
    /// - Parameters:
    ///     - withBaseURL: the base url of the API call
    ///     - body: body to be passed in the call in form of Any Object
    ///     - completion: callback with AnyObject and ServerError Object
    func post(withBaseURL: String,
              body: Dictionary<String, String>? = nil,
              completion: @escaping (_ result: AnyObject?, _ error: ServerError?) -> Void) {
        
        if let url = URLComponents(string: withBaseURL)?.url {
            var request  = URLRequest(url: url)
            request.httpMethod = "POST"
            
            if let body = body {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                    return
                }
                request.httpBody = httpBody
            }
            
            request.setValue("\(String(describing: body?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        if let responseData = data, let utf8Text = String(data: responseData, encoding: .utf8) {
                            do {
                                if !utf8Text.isEmpty {
                                    if let j = try JSONSerialization.jsonObject(with: responseData, options: [.allowFragments]) as? [String: Any] {
                                        completion(j as AnyObject, nil)
                                    } else {
                                        completion(responseData as AnyObject, nil)
                                    }
                                } else {
                                    completion(nil, nil)
                                }
                            } catch let error as NSError {
                                let error = ServerError(err: error)
                                completion(nil, error)
                            }
                        }
                    } else {
                        if let err = error as NSError? {
                            let error = ServerError(err: err)
                            completion(nil, error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
