//
//  LinkView.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 26/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI
import Combine

struct LinkView: View {
    @ObservedObject var viewModel = LinkViewViewModel()
    
    var body: some View {
        VStack {
            if self.viewModel.showing { // Hide content when is collapsed
                Group {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(NSLocalizedString("link_title", comment: "Title for link text field"))
                            .font(.headline)
                            .foregroundColor(Color("Font"))
                        SearchBar(searchText: $viewModel.url, handler: self.viewModel.getRecipe)
                        HStack(alignment: .center) {
                            Spacer()
                            ActivityIndicator(isAnimating: self.$viewModel.loading, style: .large)
                            Spacer()
                        }
                    .padding()
                    }
                    .padding(20)
                    Spacer()
                }
            }
            HStack {
                ArrowButton(showing: self.$viewModel.showing)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color("Background"))
        .cornerRadius(40)
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView()
    }
}
