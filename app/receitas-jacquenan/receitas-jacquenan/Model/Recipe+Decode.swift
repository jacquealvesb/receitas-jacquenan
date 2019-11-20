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
                
                self.current = true         // default value
                self.finished = false       // default value
                self.image = translatedJSON["thumbnail"] as? String ?? ""
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

            }
        } catch let error {
            print(error)
        }
    }
}
