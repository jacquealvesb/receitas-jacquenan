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
        guard let ingredient = RecipeSiriFacade.shared.getIngredient(named: intent.ingredient) else { // Try to get the ingredient from the recipe
            completion(IngredientAmountIntentResponse.init(code: .failureNoIngredient, userActivity: nil)) // Fails responding the recipe doesnt have the ingredient
            return
        }
        
        let amount = ingredient.amount ?? ""
        let ingredientName = ingredient.name ?? ""
        
        completion(IngredientAmountIntentResponse.success(amount: amount, ingredient: ingredientName)) // Respond inform the amount of the ingredient
    }
    
    func resolveIngredient(for intent: IngredientAmountIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        var result: INStringResolutionResult

        if let ingredient = intent.ingredient { // Check if the user has given the ingredient as input
            result = INStringResolutionResult.success(with: ingredient)
            
        } else {
            result = INStringResolutionResult.needsValue() // Ask for the ingredient input
        }
        
        completion(result) // Return the result back to SiriKit
    }
}