//
//  IntentHandler.swift
//  RecipesIntents
//
//  Created by Jacqueline Alves on 04/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Intents

class IntentHandler: INExtension {

    /// Returns the correct handler accordingly with the received intent
    /// - Parameter intent: Active Intent
    override func handler(for intent: INIntent) -> Any {
        if intent is IngredientAmountIntent {
            return IngredientAmountIntentHandler()
        
        } else if intent is RepeatInstructionIntent {
            return RepeatInstructionIntentHandler()
        
        } else if intent is NextInstructionIntent {
            return NextInstructionIntentHandler()
        }
        
        return self
    }
    
}
