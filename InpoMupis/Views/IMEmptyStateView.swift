//
//  IMEmptyStateView.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/27/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class IMEmptyStateView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func configure() {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        addSubview(messageLabel)
        
        backgroundColor = .systemBackground
        
        imageView.image = UIImage(named: "surf")
        
        
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
