//
//  WeightViewModel.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

class WeightViewModel {
    
    var isFetchWeightsSuccess: Dynamic<Bool> = Dynamic(false)
    var weightData: Double?
    var infoMessage: String?
    var errorMessage = ""
    let store = WeightStore()
    
    /// This function fetches the weight data from the network service.
    ///
    /// Calls the network service class function to fetch the weight data from the API.
    /// Receives the response containing the weight data, if error occurs, receives the Server Error with error message.
    /// if error nil, set data to class variable and set isFetchWeightSuccess to true
    /// if error not nil, set error message and set isFetchWeightSuccess to false
    func fetchWeightData() {
        store.fetchWeighht() { [weak self]
            (result, error)  in
            if error == nil {
                if let data = result?.data {
                    self?.weightData = data.weight
                    self?.infoMessage = data.message
                    print(data)
                }
                self?.isFetchWeightsSuccess.value = true
            } else {
                self?.errorMessage = error?.errorMessage ?? StringConstants.defaultError
                self?.isFetchWeightsSuccess.value = false
            }
        }
    }
}

