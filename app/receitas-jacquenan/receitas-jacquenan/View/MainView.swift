//
//  MainView.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 29/10/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = MainViewViewModel()
    
    var body: some View {
        VStack {
            TextField("URL", text: $viewModel.url)
            Button(action: self.viewModel.getRecipe) {
                Text("Procurar")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
