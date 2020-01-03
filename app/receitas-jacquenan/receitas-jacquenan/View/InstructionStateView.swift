//
//  InstructionStateView.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 03/01/20.
//  Copyright © 2020 jacquenan. All rights reserved.
//

import SwiftUI

struct InstructionStateView: View {
    @Binding var state: Data
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(width: 25, height: 25, alignment: .center)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
            
            Image(uiImage: UIImage(data: self.state) ?? UIImage())
                .renderingMode(.original)
                .frame(width: 45, height: 45)
        }
    }
}

//struct InstructionStateView_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructionStateView()
//    }
//}
