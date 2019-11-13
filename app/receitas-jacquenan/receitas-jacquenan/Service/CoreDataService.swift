//
//  CoreDataService.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 13/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import CoreData

class CoreDataService {
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var persistentContainer: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        let container: NSPersistentContainer = {
            /*
            The persistent container for the application. This implementation
            creates and returns a container, having loaded the store for the
            application to it. This property is optional since there are legitimate
            error conditions that could cause the creation of the store to fail.
            */
            let container = NSCustomPersistentContainer(name: "receitas-jacquenan")
            
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                } else {
                    print(storeDescription)
                }
            })
            
            return container
        }()
        
        self.init(container: container)
    }
    
    // MARK: - Core Data Saving support
    func saveContext() throws {
        if context.hasChanges {
            do {
               try self.context.save()
                
            } catch let error as NSError {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                throw error
            }
        }
    }
    
    // MARK: - Fetch
    
    /// Fetch current recipe
    func fetchCurrentRecipe() throws -> Recipe? {
        let fetchRequest = NSFetchRequest<Recipe>(entityName: "Recipe")
        
        fetchRequest.predicate = NSPredicate(format: "current == YES")
        
        do {
            let recipe = try context.fetch(fetchRequest)
            
            return recipe.first
            
        } catch let error as NSError {
            throw error
        }
    }
    
    func fetchAll() throws -> [Recipe] {
        let fetchRequest = NSFetchRequest<Recipe>(entityName: "Recipe")
        
        do {
            let recipes = try context.fetch(fetchRequest)
            
            return recipes
            
        } catch let error as NSError {
            throw error
        }
    }
    
    // MARK: - Insert methods
    func insertRecipe(current: Bool, finished: Bool, image: Data, name: String,
                      starred: Bool, ingredients: [Ingredient], instructions: [Instruction]) -> Recipe? {
        let recipe = Recipe(context: self.context)
        recipe.current = current
        recipe.finished = finished
        recipe.image = image
        recipe.name = name
        recipe.starred = starred
        
        recipe.addToInstructions(NSOrderedSet(array: instructions))
        recipe.addToIngredients(NSSet(array: ingredients))
        
        do {
            try self.saveContext()
            return recipe
        } catch let error as NSError {
            print("\(error)")
            return nil
        }
    }
    
    func insertIngredient(amount: String, name: String) -> Ingredient {
        
        let ingredient = Ingredient(context: self.context)
        ingredient.amount = amount
        ingredient.name = name
        
        return ingredient
        
    }
    
    func insertInstruction(instructionContent: String, state: Int) -> Instruction {
        
        let instruction = Instruction(context: self.context)
        instruction.instruction = instructionContent
        instruction.state = Int16(state)
        
        return instruction
        
    }
    
    // MARK: - Delete
    func delete(object: NSManagedObject) {
        self.context.delete(object)
        
        do {
            try self.saveContext()
        } catch let error as NSError {
            print("\(error)")
        }
    }
}
