//
//  AddToSiriOnBoarding.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 03/01/20.
//  Copyright © 2020 jacquenan. All rights reserved.
//

import UIKit
import IntentsUI

class AddToSiriOnBoarding: UIView {
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.textColor = UIColor(named: "Font")
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.textColor = UIColor(named: "Font")
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    lazy var siriHelpLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
        view.textColor = UIColor(named: "Font")
        view.numberOfLines = 0
        view.textAlignment = .center
        view.text = NSLocalizedString("onboarding_siri_help", comment: "Text for Siri button help on onboarding")
        return view
    }()
    
    lazy var siriButton: INUIAddVoiceShortcutButton = {
        let view = INUIAddVoiceShortcutButton(style: .whiteOutline)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    func setTitle(_ text: String) {
        self.titleLabel.text = text.uppercased()
    }
    
    func setText(_ text: String) {
        self.textLabel.text = text
    }
    
    func setSiriButton(intent: INIntent, delegate: INUIAddVoiceShortcutButtonDelegate?) {
        self.siriButton.shortcut = INShortcut(intent: intent)
        self.siriButton.delegate = delegate
    }
}

extension AddToSiriOnBoarding {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(siriButton)
        addSubview(siriHelpLabel)
    }
    
    func setupConstraints() {
        // Image constraints
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.3, constant: 0).isActive = true
        
        // Title constraints
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        
        // Text constraints
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        // Siri constraints
        siriButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        siriButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        // Siri help constraint
        siriHelpLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        siriHelpLabel.bottomAnchor.constraint(equalTo: siriButton.topAnchor, constant: -10).isActive = true
        siriHelpLabel.widthAnchor.constraint(equalTo: siriButton.widthAnchor, multiplier: 1.2).isActive = true
    }
}
