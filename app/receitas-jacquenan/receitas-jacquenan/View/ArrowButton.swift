//
//  ArrowButton.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 27/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI

struct ArrowButton: View {
    @Binding var showing: Bool
    
    var body: some View {
        Button(action: self.toggle) {
            Image(self.showing ? "arrow.up" : "arrow.down")
                .foregroundColor(Color.white)
                .padding(.top, self.showing ? 0 : 150)
                .padding(.bottom)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
        }
    }
    
    func toggle() {
        withAnimation {
            self.showing.toggle()
        }
    }
}

//struct ArrowButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ArrowButton(showing: true)
//    }
//}
