//
//  Instruction+Decode.swift
//  receitas-jacquenan
//
//  Created by rfl3 on 18/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation

extension Instruction {
    func decode(_ rawInstruction: Any) {
        
        if let instruction = rawInstruction as? String {
            
            self.instruction = instruction
            self.state = 0  // default value
            
        } else {
            return
        }
        
    }
}
