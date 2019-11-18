//
//  Recipe+Codable.swift
//  receitas-jacquenan
//
//  Created by rfl3 on 18/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation

extension Recipe {
    func decodeRecipe(_ json: Data) {
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [Dictionary<String, Any>] {
                print(jsonArray)
            }
        } catch let error {
            print(error)
        }
    }
}
