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
        // TO DO: Get the next instruction and set it as the current one
        let instruction = "Tell the next instruction that has been get from CoreData"
        
        completion(NextInstructionIntentResponse.success(instruction: instruction))
    }
}
