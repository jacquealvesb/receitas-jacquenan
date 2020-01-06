//
//  TextOnBoarding.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 03/01/20.
//  Copyright © 2020 jacquenan. All rights reserved.
//

import UIKit

class TextOnBoarding: UIView {
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        view.setTitle("COMEÇAR", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(named: "Background")
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        view.isHidden = true
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
    
    func setButtonAction(_ action: Selector) {
        self.button.isHidden = false
        self.button.addTarget(nil, action: action, for: .touchUpInside)
    }
}

extension TextOnBoarding {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(button)
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
        
        // Button constaints
        button.widthAnchor.constraint(equalToConstant: 190).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
