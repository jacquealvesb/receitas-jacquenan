//
//  LinkViewModel.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 26/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation
import Combine

class LinkViewViewModel: ObservableObject {
    @Published var url: String = ""
    @Published var loading: Bool = false
    @Published var showing: Bool = true
    
    func getRecipe() {
        if !url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.loading = true
            RequestService(self).getRecipe(url)
        }
    }
    
}

extension LinkViewViewModel: RequestServiceDelegate {
    func didReceiveData(_ data: Data) {
        DispatchQueue.main.async {
            self.loading = false
            self.url = ""
        }
        
        // Set the last recipe as not current
        guard let recipe = CoreDataService.shared.insertRecipe(data) else { return }
        CoreDataService.shared.replaceCurrentRecipe(with: recipe)
        DispatchQueue.main.async {
            self.showing = false
        }
    }
}
