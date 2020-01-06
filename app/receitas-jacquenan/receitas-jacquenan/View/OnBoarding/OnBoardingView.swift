//
//  OnBoardingView.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 03/01/20.
//  Copyright © 2020 jacquenan. All rights reserved.
//

import UIKit
import IntentsUI

class OnBoardingView: UIViewController {
    lazy var screen: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        return view
    }()
    
    var index = 0
    var pages = [UIViewController]()
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let pageControl = UIPageControl()
    
    // Intents
    lazy var ingredientAmountIntent: IngredientAmountIntent = {
        let intent = IngredientAmountIntent()
        
        intent.suggestedInvocationPhrase = "Quanto eu coloco?"
        
        return intent
    }()
    
    lazy var repeatInstructionIntent: RepeatInstructionIntent = {
        let intent = RepeatInstructionIntent()
        
        intent.suggestedInvocationPhrase = "Repetir passo"
        
        return intent
    }()
    
    lazy var nextInstructionIntent: NextInstructionIntent = {
        let intent = NextInstructionIntent()
        
        intent.suggestedInvocationPhrase = "Próximo passo"
        
        return intent
    }()
    
    override func loadView() {
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let page1 = TextOnBoardingViewController(image: #imageLiteral(resourceName: "onboarding_hat"),
                                                 title: "COLOQUE O LINK DE UMA RECEITA E COMECE A COZINHAR",
                                                 text: "A gente pega ela e deixa bonitinha pra você!")
        let page2 = AddToSiriOnBoardingViewController(image: #imageLiteral(resourceName: "onboarding_ingredient"),
                                                      title: "PEÇA AJUDA PARA A SIRI",
                                                      text: "Pergunte quanto de um ingrediente você precisa colocar.",
                                                      intent: ingredientAmountIntent)
        let page3 = AddToSiriOnBoardingViewController(image: #imageLiteral(resourceName: "onboarding_repeat"),
                                                      title: "PEÇA AJUDA PARA A SIRI",
                                                      text: "Peça para ela repetir o passo atual que você esqueceu.",
                                                      intent: repeatInstructionIntent)
        let page4 = AddToSiriOnBoardingViewController(image: #imageLiteral(resourceName: "onboarding_next"),
                                                      title: "PEÇA AJUDA PARA A SIRI",
                                                      text: "Peça para ela dizer o próximo passo que você deve fazer.",
                                                      intent: nextInstructionIntent)
        let page5 = TextOnBoardingViewController(image: #imageLiteral(resourceName: "onboarding_hat"), title: "", text: "", action: #selector(finish))
        
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        self.pages.append(page4)
        self.pages.append(page5)
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        if let firstVC = pages.first {
            self.pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        addChild(pageViewController)
        pageViewController.view.frame = view.frame
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        setupPageControl()
    }
    
    func setupPageControl() {
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.gray
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = 0
        
        self.view.addSubview(self.pageControl)

        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func finish() {
        UserDefaults.standard.set(true, forKey: "finish_onboarding")
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            let viewController = sceneDelegate.viewControllerFor(MainView())
            viewController.modalPresentationStyle = .fullScreen
            
            present(viewController, animated: true)
        }
    }
}

extension OnBoardingView: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard (previousIndex >= 0) && (pages.count > previousIndex) else { return nil }
        
        self.index = previousIndex
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard (nextIndex < pages.count) && (pages.count > nextIndex) else { return nil }
        
        self.index = nextIndex
        
        return pages[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return index
    }
}

extension OnBoardingView: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}
