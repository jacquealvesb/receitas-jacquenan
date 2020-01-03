//
//  RecipeViewViewModel.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 26/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown, incorrectURL, apiError(reason: String)
}

class RecipeViewViewModel: ObservableObject {
    private var recipe: Recipe?
    
    var name: String {
        return recipe?.name ?? "Receita"
    }
    
    var hasRecipe: Bool {
        return recipe != nil
    }
    
    @Published var image: Data = Data()
    @Published var ingredients = [Ingredient]()
    @Published var instructions = [Instruction]()
    
    var instructionCount: Int {
        return self.instructions.count
    }
    
    var recipeCancellable: AnyCancellable?
    
    init() {
        // Fetch first recipe when init app
        let recipe = try? CoreDataService.shared.fetchCurrentRecipe()
        self.updateRecipe(with: recipe)
        
        // Receive recipe when one is inserted on context
        self.recipeCancellable = CoreDataService.shared.contextChangedPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] hasChanges in
                if hasChanges {
                    let recipe = try? CoreDataService.shared.fetchCurrentRecipe()
                    self?.updateRecipe(with: recipe)
                }
            }
//        stateCancellable = CoreDataService.shared.persistentContainer.viewContext
//            .publisher(for: \.insertedObjects)
//            .receive(on: DispatchQueue.main)
//            .map { insertedObjects -> Recipe? in
//                return insertedObjects.first as? Recipe
//            }
//            .sink(receiveValue: { [weak self] recipe in
//                self?.updateRecipe(with: recipe)
//            })
    }
    
    private func updateRecipe(with recipe: Recipe?) {
        self.recipe = recipe
        if let ingredients = recipe?.ingredients?.allObjects as? [Ingredient] {
            self.ingredients = ingredients
        }
        if let instructions = recipe?.instructions?.array as? [Instruction] {
            self.instructions = instructions
        }
        self.downloadImage()
    }
    
    private func downloadImage() {
        guard let imageURL = self.recipe?.image else { return }
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = data
            }
        }.resume()
    }
    
    public func viewModelForInstruction(at index: Int) -> InstructionViewModel? {
        guard index < self.instructions.count else { return nil }
        return InstructionViewModel(instruction: self.instructions[index], setCurrent: self.setCurrentInstruction(at:))
    }
    
    public func setCurrentInstruction(at index: Int) {
        guard index < self.instructions.count else { return }
        
        for (currentIndex, instruction) in self.instructions.enumerated() {
            if currentIndex < index {
                instruction.state = InstructionState.done.rawValue
            } else if currentIndex == index {
                instruction.state = InstructionState.current.rawValue
            } else {
                instruction.state = InstructionState.toDo.rawValue
            }
        }
        
        try? CoreDataService.shared.saveContext()
    }
}
