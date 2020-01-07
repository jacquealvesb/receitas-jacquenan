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
        let recipeFacade = RecipeSiriFacade()

        guard let ingredient = recipeFacade.getIngredient(named: intent.ingredient) else { // Try to get the ingredient from the recipe
            completion(IngredientAmountIntentResponse.init(code: .failureNoIngredient, userActivity: nil)) // Fails responding the recipe doesnt have the ingredient
            return
        }
        
        let ingredientName = ingredient.name ?? ""
//        let amount = ingredient.amount ?? ""
        
//        completion(IngredientAmountIntentResponse.success(amount: amount, ingredient: ingredientName)) // Respond inform the amount of the ingredient
        
        // Temporary solution untill we don't separate the ingredient and its amount
        completion(IngredientAmountIntentResponse.success(ingredient: ingredientName)) // Respond inform the amount of the ingredient
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
