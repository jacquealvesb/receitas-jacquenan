//
//  Recipe+Decode.swift
//  receitas-jacquenan
//
//  Created by rfl3 on 18/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation
import CoreData

extension Recipe {
    
    func decode(_ json: Data) {
        do {
            
            if let translatedJSON = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String: Any] {

                guard let context = self.managedObjectContext else { return }
                
                self.current = false        // default value
                self.finished = false       // default value
                self.image = nil            // default value
                self.name = translatedJSON["title"] as? String ?? ""
                self.starred = false        // default value
                
                for rawInstruction in translatedJSON["instructions"] as? NSArray ?? [] {
                    
                    let instruction = Instruction(context: context)
                    instruction.decode(rawInstruction)
                    
                    self.addToInstructions(instruction)
                    
                }
                
                for rawIngredient in translatedJSON["ingredients"] as? NSArray ?? [] {
                    
                    let ingredient = Ingredient(context: context)
                    ingredient.decode(rawIngredient)
                    
                    self.addToIngredients(ingredient)
                    
                }
                
                if let url = URL(string: translatedJSON["thumbnail"] as? String ?? "") {
                    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                        if let error = error {
                            print(error)
                        } else {
//                            self.image = data
                        }
                    }
                    
                    task.resume()
                }

            }
        } catch let error {
            print(error)
        }
    }
}
