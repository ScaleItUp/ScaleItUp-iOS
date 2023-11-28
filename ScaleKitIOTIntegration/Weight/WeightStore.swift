//
//  WeightStore.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

class WeightStore {
    
    let service = NetworkService()
    
    /// This function fetches the weight data from the service class.
    ///
    /// Calls the service class function to fetch the users data from the API. Receives the response containing the weight data, if error occurs, receives the Server Error with error message.
    /// - Parameter callback: A callback  with the parameters `result`, having the WeightModel data and `error` which is a ServerError object.
    func fetchWeighht(callback:@escaping (_ result: WeightModel?, _ error:ServerError?) -> Void) {
        service.get(withBaseURL: NetworkConstants.getWeightAPI) {
            (result, error) in
            let decoder = JSONDecoder()
            if error == nil {
                if let resultData = result, let decodedData = try? decoder.decode(WeightModel.self, from: resultData) {
                    callback(decodedData, nil)
                } else {
                    callback(nil, CommonUtils.sharedInstance.defaultError())
                }
            } else {
                callback(nil, error)
            }
        }
    }
}

