//
//  InstructionViewModel.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 25/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation
import Combine

class InstructionViewModel: ObservableObject, Identifiable {
    private let instruction: Instruction
    
    var description: String {
        return self.instruction.instruction ?? ""
    }
    
    @Published var state: Data = Data()
    
    var setCurrent: (Int) -> Void
    
    var stateCancellable: AnyCancellable?
    
    init(instruction: Instruction, setCurrent: @escaping (Int) -> Void) {
        self.instruction = instruction
        self.setCurrent = setCurrent
        
        // Linsten to changes in state variable returning the image to put on the checkbox
        self.stateCancellable = self.instruction
            .publisher(for: \.state)
            .receive(on: DispatchQueue.main)
            .map { state -> Data? in
                var imageName: String = ""
                switch state {
                case InstructionState.current.rawValue:
                    imageName = "current"
                case InstructionState.done.rawValue:
                    imageName = "done"
                default:
                    return nil
                }
                
                guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil }
                
                return try? Data(contentsOf: url)
            }
            .sink { [weak self] data in
                self?.state = data ?? Data()
            }
    }
    
//    public func setCurrent() {
//        print("esse é o atual")
//    }
}
