//
//  IngredientViewModel.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 25/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation
import Combine

class IngredientViewModel: ObservableObject, Identifiable {
    private let ingredient: Ingredient
    
    var name: String {
        return self.ingredient.name ?? ""
    }
    
    var amount: String {
        return self.ingredient.amount ?? ""
    }
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
}
