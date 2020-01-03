//
//  TextOnBoardingViewController.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 03/01/20.
//  Copyright © 2020 jacquenan. All rights reserved.
//

import UIKit

class TextOnBoardingViewController: UIViewController {
    let screen = TextOnBoarding(frame: UIScreen.main.bounds)
    
    override func loadView() {
        self.view = screen
    }

    convenience init(image: UIImage, title: String, text: String, action: Selector? = nil) {
        self.init()
        
        screen.setImage(image)
        screen.setTitle(title)
        screen.setText(text)
        
        if let action = action {
            screen.setButtonAction(action)
        }
    }
}
