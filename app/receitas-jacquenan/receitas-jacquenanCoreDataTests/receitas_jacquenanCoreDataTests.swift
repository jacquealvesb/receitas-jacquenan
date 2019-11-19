//
//  receitas_jacquenanCoreDataTests.swift
//  receitas-jacquenanCoreDataTests
//
//  Created by Jacqueline Alves on 13/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import XCTest
import CoreData
@testable import receitas_jacquenan

class receitas_jacquenanCoreDataTests: XCTestCase {
    
    static var persistentContainer: NSPersistentContainer?
    
    var context: NSManagedObjectContext {
        return receitas_jacquenanCoreDataTests.persistentContainer!.viewContext
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        super.setUp()
        
        if receitas_jacquenanCoreDataTests.persistentContainer == nil {
            receitas_jacquenanCoreDataTests.persistentContainer = self.mockPersistentContainer()
            
            CoreDataService.shared.persistentContainer = receitas_jacquenanCoreDataTests.persistentContainer!
        }
        self.initStubs()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.flushData()
        super.tearDown()
    }

    // MARK: - Test functions
    func testCreateRecipe() {
        
        let ingredient = CoreDataService.shared.insertIngredient(amount: "500ml", name: "caldo de galinha")
        let instruction = CoreDataService.shared.insertInstruction(instructionContent: "Bota o negocio na coxisa", state: 0)
        
        let recipe = CoreDataService.shared.insertRecipe(current: false,
                                                         finished: false,
                                                         image: Data(),
                                                         name: "Bolo de rolo",
                                                         starred: false,
                                                         ingredients: [ingredient],
                                                         instructions: [instruction])
        
        // Assert
        XCTAssertNotNil(recipe)
    }
    
    func testFetchAllRecipes() {
        do {
            let results = try CoreDataService.shared.fetchAll()
            
            XCTAssertEqual(results.count, 5)
            
        } catch {
            XCTFail()
        }
    }
    
    func testFetchCurrentRecipe() {
        do {
            let recipe = try CoreDataService.shared.fetchCurrentRecipe()
            
            XCTAssertNotNil(recipe)
        } catch {
            XCTFail()
        }
    }
    
    func testRemoveRecipe() {
        do {
            let recipes = try CoreDataService.shared.fetchAll()
            let recipe = recipes.first
            let numberOfItems = recipes.count // Check how many recipes are in Core Data before deletion
            
            if let recipe = recipe {
                CoreDataService.shared.delete(object: recipe)
                
                do {
                    let currentRecipes = try CoreDataService.shared.fetchAll() // Check how many recipes are in Core Data after deletion
                    
                    XCTAssertEqual(currentRecipes.count, numberOfItems - 1)

                } catch {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    // MARK: - Auxiliar functions
    func initStubs() {
        
        func insertRecipe(current: Bool, finished: Bool, image: Data, name: String, starred: Bool) {
            let recipe = Recipe(context: self.context)
            recipe.current = current
            recipe.finished = finished
            recipe.image = image
            recipe.name = name
            recipe.starred = starred
            
            let instruction = Instruction(context: self.context)
            instruction.instruction = "Bota a coisa no negocio"
            instruction.state = Int16(0)
            
            let instructions = [instruction, instruction]
            
            recipe.addToInstructions(NSOrderedSet(array: instructions))
            
            let ingredient = Ingredient(context: self.context)
            ingredient.amount = "500ml"
            ingredient.name = "caldo de galinha"
            
            let ingredients = [ingredient, ingredient, ingredient]
            
            recipe.addToIngredients(NSSet(array: ingredients))
        }
        
        insertRecipe(current: false, finished: false, image: Data(), name: "Bolo de rolo", starred: false)
        insertRecipe(current: true, finished: false, image: Data(), name: "Bolo de cenoura", starred: false)
        insertRecipe(current: false, finished: false, image: Data(), name: "Bolo de laranja", starred: false)
        insertRecipe(current: false, finished: false, image: Data(), name: "Bolo de chocolate", starred: false)
        insertRecipe(current: false, finished: false, image: Data(), name: "Bolo de manga", starred: false)
        
        do {
            try self.saveContext()
        } catch {
            fatalError("Ended with error: \(error.localizedDescription)")
        }
    }
    
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        let objs = try! self.context.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            self.context.delete(obj)
        }
        
        do {
            try self.saveContext()
        } catch {
            fatalError("Ended with error: \(error.localizedDescription)")
        }
    }
}

// MARK: - Auxiliar functions
extension receitas_jacquenanCoreDataTests {
    func mockPersistentContainer() -> NSPersistentContainer {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        let container = NSCustomPersistentContainer(name: "receitas-jacquenan", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            
            // Check if the data store is in memory
            precondition(description.type == NSInMemoryStoreType)
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-memory coordinator failed \(error)")
            }
        }
        
        return container
    }
    
    func saveContext() throws {
        if self.context.hasChanges {
            do {
               try self.context.save()
                
            } catch let error as NSError {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                throw error
            }
        }
    }
}
