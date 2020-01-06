//
//  SceneDelegate.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 29/10/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import UIKit
import SwiftUI
import Intents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Donate interactions
        self.donateIngredientAmountIntent()
        self.donateRepeatInstructionIntent()
        self.donateNextInstructionIntent()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            // Check if already finished onboarding
            if let didOnBoarding = UserDefaults.standard.value(forKey: "finish_onboarding") as? Bool, didOnBoarding == true {
                let contentView = MainView()
                window.rootViewController = self.viewControllerFor(contentView)
            } else {
                let contentView = OnBoardingView()
                window.rootViewController = contentView
            }
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save context when enter background
        try? CoreDataService.shared.saveContext()
    }
}

extension SceneDelegate {
    func viewControllerFor<T: View>(_ swiftUIView: T) -> UIViewController {
        return UIHostingController(rootView: swiftUIView)
    }
}

// MARK: - Interaction donations
//
// To be added to Siri Shortcut, an intent has to already been used before, so we donate the intent in order to do that
//
extension SceneDelegate {
    func donateIngredientAmountIntent() {
        let intent = IngredientAmountIntent()
        
        intent.suggestedInvocationPhrase = "How much do I put?"
        intent.ingredient = "ingredient"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if let error = error as NSError? {
                print("Interaction donation failed: \(error.description)")
            } else {
                print("Successfully donated interaction")
            }
        }
    }
    
    func donateRepeatInstructionIntent() {
        let intent = RepeatInstructionIntent()
        
        intent.suggestedInvocationPhrase = "Repeat instruction"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if let error = error as NSError? {
                print("Interaction donation failed: \(error.description)")
            } else {
                print("Successfully donated interaction")
            }
        }
    }
    
    func donateNextInstructionIntent() {
        let intent = NextInstructionIntent()
        
        intent.suggestedInvocationPhrase = "Next instruction"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if let error = error as NSError? {
                print("Interaction donation failed: \(error.description)")
            } else {
                print("Successfully donated interaction")
            }
        }
    }
}
