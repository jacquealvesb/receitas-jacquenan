//
//  RecipeViewModel.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 18/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    let recipe: Recipe
    
    @Published var ingredients: [Ingredient] = []
    @Published var instructions: [Instruction] = []
    
    var currentInstruction: Instruction? {
        return self.instructions.filter { $0.state == InstructionState.current.rawValue }.first
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
        
        _ = self.recipe.objectWillChange.sink { _ in
            self.update()
        }
    }
    
    func update() {
        self.ingredients = self.recipe.ingredients?.allObjects as? [Ingredient] ?? []
        self.instructions = self.recipe.instructions?.array as? [Instruction] ?? []
    }
}
