//
//  WeightModel.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

enum WeightModelKeys: CodingKey {
    case code, data, message
}

struct WeightModel: Codable {
    var code: Int?
    var data: WeightInfoModel?
    var message: String?
}

extension WeightModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeightModelKeys.self)
        code = try? container.decodeIfPresent(Int.self, forKey: .code)
        data = try? container.decodeIfPresent(WeightInfoModel.self, forKey: .data)
        message = try? container.decodeIfPresent(String.self, forKey: .message)
    }
}

enum WeightInfoModelKeys: CodingKey {
    case message, weight
}

struct WeightInfoModel: Codable {
    var message: String?
    var weight: Double?
}

extension WeightInfoModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeightInfoModelKeys.self)
        message = try? container.decodeIfPresent(String.self, forKey: .message)
        weight = try? container.decodeIfPresent(Double.self, forKey: .weight)
    }
}
