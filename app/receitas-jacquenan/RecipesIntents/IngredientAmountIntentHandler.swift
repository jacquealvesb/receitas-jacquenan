//
//  IngredientAmountIntentHandler.swift
//  IngredientAmountIntent
//
//  Created by Jacqueline Alves on 04/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Intents

class IngredientAmountIntentHandler: NSObject, IngredientAmountIntentHandling {
    
    func handle(intent: IngredientAmountIntent, completion: @escaping (IngredientAmountIntentResponse) -> Void) {
        // TO DO: Get the amount of the ingredient to tell user
        completion(IngredientAmountIntentResponse.success(amount: "10g", ingredient: intent.ingredient ?? "ingredient"))
    }
    
    func resolveIngredient(for intent: IngredientAmountIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        var result: INStringResolutionResult
        
        // TO DO: Get the list of ingredients from the current recipe
        let ingredients = ["Arroz", "Rice"]
        
        // If the ingredient is valid, use it; otherwise,
        // let the user know it is not supported
        if let ingredient = intent.ingredient {
            
            if ingredients.contains(ingredient) {
                result = INStringResolutionResult.success(with: ingredient)
            } else {
                result = INStringResolutionResult.unsupported()
            }
            
        } else {
            // Ask for the ingredient to tell amount
            result = INStringResolutionResult.needsValue()
        }
        
        // Return the result back to SiriKit
        completion(result)
    }
}
