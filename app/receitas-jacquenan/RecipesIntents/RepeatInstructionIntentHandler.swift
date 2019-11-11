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
        // TO DO: Get the current instruction
        let instruction = "Repeat the current instruction that has been get from CoreData"
        
        completion(RepeatInstructionIntentResponse.success(instruction: instruction))
    }
}
