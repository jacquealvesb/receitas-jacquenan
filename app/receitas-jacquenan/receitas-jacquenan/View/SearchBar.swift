//
//  SearchBar.swift
//  receitas-jacquenan
//
//  Created by rfl3 on 25/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    
    @State private var showCancelButton: Bool = false
    @Binding var searchText: String
    var handler: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.trailing, 5)
                .padding(.leading, 10)
                .foregroundColor(Color.gray)
            
            TextField("http://linkdareceita.com.br", text: $searchText, onEditingChanged: { _ in
                self.showCancelButton = true
            }, onCommit: self.handler)
                .foregroundColor(Color.black)
                .padding(.vertical, 10)
            
            Button(action: {
                self.searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
            }.padding(.trailing, 10)
                .padding(.leading, 5)
                .foregroundColor(Color.gray)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
    }
}
