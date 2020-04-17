//
//  MovieCell.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.image = UIImage(named: "aadc2")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ada Apa dengan Cinta? 2"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        
        return label  
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(nameLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width * 1.3)
        nameLabel.frame = CGRect(x: 0, y: imageView.frame.height, width: frame.width, height: 40)
        
    }
    
    
}
