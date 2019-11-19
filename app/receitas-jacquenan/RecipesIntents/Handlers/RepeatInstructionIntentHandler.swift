//
//  RepeatInstructionIntentHandler.swift
//  RecipesIntents
//
//  Created by Jacqueline Alves on 11/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Intents

class RepeatInstructionIntentHandler: NSObject, RepeatInstructionIntentHandling {
    func handle(intent: RepeatInstructionIntent, completion: @escaping (RepeatInstructionIntentResponse) -> Void) {
        // Get current instruction
        guard let current = RecipeSiriFacade.shared.currentInstruction else {
            completion(RepeatInstructionIntentResponse.init(code: .failure, userActivity: nil)) // Fails
            return
        }
        
        completion(RepeatInstructionIntentResponse.success(instruction: current.instruction ?? "" )) // Responds with the current instruction
    }
}
