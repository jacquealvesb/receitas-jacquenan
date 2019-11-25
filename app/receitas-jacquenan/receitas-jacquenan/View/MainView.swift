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
        ZStack {
            Color("Background").edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Link da receita")
                    .font(.headline)
                    .foregroundColor(Color(red: 60/255, green: 65/255, blue: 59/255))
                SearchBar(searchText: $viewModel.url, handler: self.viewModel.getRecipe)
            }
            .padding(20)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
