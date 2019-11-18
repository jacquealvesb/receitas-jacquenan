//
//  MainViewViewModel.swift
//  receitas-jacquenan
//
//  Created by rfl3 on 14/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import Foundation
import Combine

class MainViewViewModel: ObservableObject {
    @Published var url: String = ""
    
//    var oi = Recipe(context: <#T##NSManagedObjectContext#>)
    
    func getRecipe() {
        RequestService(self).getRecipe(url)
    }
    
}

extension MainViewViewModel: RequestServiceDelegate {
    func didReceiveData(_ data: Data) {
        
    }
}
