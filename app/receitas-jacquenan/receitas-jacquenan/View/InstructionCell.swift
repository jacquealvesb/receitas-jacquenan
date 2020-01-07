//
//  InstructionCell.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 27/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI

struct InstructionCell: View {
    @ObservedObject var viewModel: InstructionViewModel
    var order: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(order + 1). \(viewModel.description)")
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color("Font"))
                Spacer()
                Button(action: {
                    self.viewModel.setCurrent(self.order)
                }, label: {
                    InstructionStateView(state: self.$viewModel.state)
                })
            }
            Divider()
                .colorMultiply(.gray)
        }
    }
}

struct InstructionCell_Previews: PreviewProvider {
    static var viewModel: InstructionViewModel = {
        let instruction = Instruction(context: CoreDataService.shared.persistentContainer.viewContext)
        instruction.instruction = "Corte o frango em pequenos cubos de tamanhos parecidos"
        instruction.state = InstructionState.current.rawValue
        
        let setCurrent: (Int) -> Void = { current in
            print("\(current)")
        }
        
        return InstructionViewModel(instruction: instruction, setCurrent: setCurrent)
    }()
    
    static var previews: some View {
        InstructionCell(viewModel: viewModel, order: 1)
    }
}
