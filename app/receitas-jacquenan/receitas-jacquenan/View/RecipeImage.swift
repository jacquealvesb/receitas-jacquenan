//
//  RecipeImage.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 27/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI

struct RecipeImage: View {
    @Binding var image: Data
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(uiImage: UIImage(data: self.image) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack {
                Rectangle()
                    .background(Color.black)
                    .opacity(0.3)
                Rectangle()
                    .foregroundColor(Color.white)
            }
            
        }
    }
}

//struct RecipeImageView_Previews: PreviewProvider {
//    @Published var image = Data()
//    static var previews: some View {
//        RecipeImage(image: image)
//    }
//}
