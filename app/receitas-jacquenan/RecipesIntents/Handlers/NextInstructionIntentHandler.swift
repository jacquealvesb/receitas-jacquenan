//
//  NextInstructionIntentHandler.swift
//  RecipesIntents
//
//  Created by Jacqueline Alves on 11/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Intents

class NextInstructionIntentHandler: NSObject, NextInstructionIntentHandling {
    func handle(intent: NextInstructionIntent, completion: @escaping (NextInstructionIntentResponse) -> Void) {
        guard let finishedRecipe = RecipeSiriFacade.shared.finishedRecipe else { // Get if the current instruction is the last one
            completion(NextInstructionIntentResponse.init(code: .failure, userActivity: nil)) // Fails
            return
        }
        
        if finishedRecipe { // Check if the current instruction is the last one
            completion(NextInstructionIntentResponse(code: .lastInstruction, userActivity: nil))
            
        } else {
            guard let next = RecipeSiriFacade.shared.replaceCurrentInstruction() else { // Go to the next instruction
                completion(NextInstructionIntentResponse.init(code: .failure, userActivity: nil)) // Fails
                return
            }
            
            completion(NextInstructionIntentResponse.success(instruction: next.instruction ?? "")) // Respond with the next instruction
        }
    }
}
