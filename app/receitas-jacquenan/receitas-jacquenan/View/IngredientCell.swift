//
//  IngredientCell.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 27/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI

struct IngredientCell: View {
    @ObservedObject var viewModel: IngredientViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
//                Text(viewModel.amount)
                Text(viewModel.name)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color("Font"))
            }
            Divider()
                .colorMultiply(.gray)

        }
    }
}

struct IngredientCell_Previews: PreviewProvider {
    static var viewModel: IngredientViewModel = {
        let ingredient = Ingredient(context: CoreDataService.shared.persistentContainer.viewContext)
        ingredient.amount = "200g"
        ingredient.name = "de frango"
        return IngredientViewModel(ingredient: ingredient)
    }()
    
    static var previews: some View {
        IngredientCell(viewModel: viewModel)
    }
}
