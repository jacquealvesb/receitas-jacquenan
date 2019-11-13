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

    var sut: CoreDataService!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
    lazy var mockPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PersistentTestJacquenan", managedObjectModel: self.managedObjectModel)
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
    }()
    
    var context: NSManagedObjectContext {
        return mockPersistentContainer.viewContext
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        super.setUp()
        self.initStubs()
        sut = CoreDataService(container: mockPersistentContainer)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.flushData()
        super.tearDown()
    }

    // MARK: - Test functions
    func testCreateRecipe() {
        
        let ingredient = sut.insertIngredient(amount: "500ml", name: "caldo de galinha")
        let instruction = sut.insertInstruction(instructionContent: "Bota o negocio na coxisa", state: 0)
        
        let recipe = sut.insertRecipe(current: false,
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
            let results = try self.sut.fetchAll()
            
            XCTAssertEqual(results.count, 5)
            
        } catch {
            XCTFail()
        }
    }
    
    func testFetchCurrentRecipe() {
        do {
            let recipe = try self.sut.fetchCurrentRecipe()
            
            XCTAssertNotNil(recipe)
        } catch {
            XCTFail()
        }
    }
    
    func testRemoveRecipe() {
        do {
            let recipes = try self.sut.fetchAll()
            let recipe = recipes.first
            let numberOfItems = recipes.count // Check how many recipes are in Core Data before deletion
            
            if let recipe = recipe {
                self.sut.delete(object: recipe)
                
                do {
                    let currentRecipes = try self.sut.fetchAll() // Check how many recipes are in Core Data after deletion
                    
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
            try self.context.save()
        } catch {
            print("\n\n\n\n\n\(error)")
        }
    }
    
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        let objs = try! self.context.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            self.context.delete(obj)
        }
        
        do {
            try self.context.save()
        } catch {
            print("\n\n\n\n\n\(error)")
        }
    }
}
