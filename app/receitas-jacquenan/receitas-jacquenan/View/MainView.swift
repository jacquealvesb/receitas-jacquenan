//
//  MainView.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 29/10/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {    
    var body: some View {
        ZStack {
            RecipeView()
            VStack {
                LinkView()
                    .padding(.top, -125)
                Spacer()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
