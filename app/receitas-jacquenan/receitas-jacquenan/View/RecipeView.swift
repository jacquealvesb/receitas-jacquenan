//
//  RecipeView.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 25/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI
import Combine

struct RecipeView: View {
    @ObservedObject var viewModel = RecipeViewViewModel()
    
    var body: some View {
        Group {
            if self.viewModel.hasRecipe {
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack(alignment: .topLeading) {
                        RecipeImage(image: self.$viewModel.image)
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(self.viewModel.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                        .padding(.vertical, 30)
                                        .foregroundColor(Color("Font"))
                                    
                                    VStack(alignment: .leading) {
                                        VStack(alignment: .leading) {
                                            Text(NSLocalizedString("ingredients_title", comment: "Title for ingredients section"))
                                                .font(.headline)
                                                .padding(.vertical)
                                                .foregroundColor(Color("Font"))
                                            ForEach(self.viewModel.ingredients, id: \.self) { ingredient in
                                                IngredientCell(viewModel: IngredientViewModel(ingredient: ingredient))
                                            }
                                        }
                                        .padding()
                                        VStack(alignment: .leading) {
                                            Text(NSLocalizedString("instructions_title", comment: "Title for instructions section"))
                                                .font(.headline)
                                                .padding(.vertical)
                                                .foregroundColor(Color("Font"))
                                            ForEach(0..<self.viewModel.instructionCount) { index in
                                                if self.viewModel.viewModelForInstruction(at: index) != nil {
                                                    InstructionCell(viewModel: self.viewModel.viewModelForInstruction(at: index)!, order: index)
                                                } else {
                                                    Rectangle()
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(30)
                            .padding(.top, 200)
                        }
                        
                    }
                }
                
            } else {
                Text(NSLocalizedString("empty_recipe_placeholder", comment: "Placeholder for when there is no saved recipes"))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
