//
//  RecipeSiriFacade.swift
//  RecipesIntents
//
//  Created by Jacqueline Alves on 19/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation

class RecipeSiriFacade {
    let recipe = try? CoreDataService.shared.fetchCurrentRecipe() // Fetch the current recipe from CoreData
    
    var instructions: [Instruction]? {
        guard let instructions = self.recipe?.instructions?.array as? [Instruction] else { return nil } // Get all instructions from the recipe
        
        return instructions
    }
    
    var ingredients: [Ingredient]? {
        guard let ingredients = self.recipe?.ingredients?.allObjects as? [Ingredient] else { return nil } // Get all instructions from the recipe
        
        return ingredients
    }
    
    var currentInstruction: Instruction? {
        guard let instructions = self.instructions else { return nil } // Get all instructions from the recipe
        guard let current = instructions.filter({ (instruction) -> Bool in // Get the index from the current instruction
            return instruction.state == InstructionState.current.rawValue
        }).first else {
            return nil
        }
        
        return current
    }
    
    var currentInstructionIndex: Int? {
        guard let instructions = self.instructions else { return nil } // Get all instructions from the recipe
        guard let currentIndex = instructions.firstIndex(where: { $0.state == InstructionState.current.rawValue }) else { return nil } // Get the index of the current instruction
        
        return currentIndex
    }
    
    var finishedRecipe: Bool? {
        guard let instructions = self.instructions else { return nil } // Get all instructions from the recipe
        guard let currentIndex = self.currentInstructionIndex else { return nil }  // Get the index of the current instruction
        
        return currentIndex == instructions.count - 1
    }
    
    /// Sets the state of the current instruction to done and of the next instruction to current
    /// Returns the next current instruction
    func replaceCurrentInstruction() -> (instruction: Instruction?, last: Bool) {
        guard let instructions = self.instructions else { return (nil, false) } // Get all instructions from the recipe
        guard let currentIndex = self.currentInstructionIndex else { return (nil, false) }  // Get the index of the current instruction
        
        let current = instructions[currentIndex]
        current.state = InstructionState.done.rawValue // Set the current instruction as done
        
        if currentIndex == instructions.count - 1 { // Check if it was the last instruction
            try? CoreDataService.shared.saveContext() // Save the changes on the CoreData
            return (nil, true)
            
        } else {
            let next = instructions[currentIndex + 1]
            next.state = InstructionState.current.rawValue // Set the next instruction as the current one
            
            try? CoreDataService.shared.saveContext() // Save the changes on the CoreData
            
            return (next, false)
        }
    }
    
    /// Get ingredient with the given name, if exists
    /// - Parameter ingredientName: Name of the ingredient to  get
    func getIngredient(named ingredientName: String?) -> Ingredient? {
        guard let ingredientName = ingredientName?.lowercased() else { return nil } // Get the ingredient lowercased
        guard let ingredients = self.ingredients else { return nil } // Get all ingredients from the recipe
        
        guard let ingredient = ingredients.first(where: { (ingredient) -> Bool in
            // return ingredient.name.lowercased() == ingredientName
            return ingredient.name?.lowercased().contains(ingredientName) ?? false
        }) else {
            return nil
        }
        
        return ingredient
    }
}
