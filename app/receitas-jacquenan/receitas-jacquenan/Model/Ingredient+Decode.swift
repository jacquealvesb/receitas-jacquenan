//
//  Ingredient+Decode.swift
//  receitas-jacquenan
//
//  Created by rfl3 on 18/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation

extension Ingredient {
    func decode(_ rawIngredient: Any) {
        
        if let ingredient = rawIngredient as? String {
            
            self.amount = "50g"     // default value change after nlp
            self.name = ingredient
            
        } else {
            return
        }
        
    }
}
