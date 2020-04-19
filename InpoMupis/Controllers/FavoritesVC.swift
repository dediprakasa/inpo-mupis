//
//  FavoritesVC.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/16/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    let backdropImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .systemPink
        iv.image = UIImage(named: "bd_aadc")
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGreen
        iv.image = UIImage(named: "aadc2")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let movieInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        
        let titleLabel = UILabel()
        titleLabel.text = "Ada Apa dengan Cinta? 2"
        titleLabel.textColor = .label
        titleLabel.backgroundColor = .systemRed
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleView = UIView()
        titleView.addSubview(titleLabel)
        titleView.backgroundColor = .systemGreen
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalToConstant: 25),
            titleView.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])
        
        let durationLabel = UILabel()
        durationLabel.text = "100 minutes"
        durationLabel.backgroundColor = .systemBlue
        durationLabel.textColor = .secondaryLabel
        
        let languageLabel = UILabel()
        languageLabel.text = "Original Language"
        languageLabel.backgroundColor = .systemGreen
        languageLabel.textColor = .label
        
        sv.addArrangedSubview(titleView)
        sv.addArrangedSubview(durationLabel)
        sv.addArrangedSubview(languageLabel)
        
        return sv
    }()
    
    func configureUI() {
        view.addSubview(backdropImageView)
        view.addSubview(posterImageView)
        view.addSubview(movieInfoStackView)

        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            
            posterImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 40),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.heightAnchor.constraint(equalToConstant: 210),
            
            movieInfoStackView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 24),
            movieInfoStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            movieInfoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            movieInfoStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor)
            
        ])
        
    }


}
