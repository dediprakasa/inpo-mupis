//
//  FavoritesVC.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/16/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var movie: Movie!
    let posterImageView = IMMoviePosterImageView(frame: .zero)
    let backdropImageView = IMMovieBackdropImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        setInfo()
        
    }
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo() {
        if let backdropUrlString = movie.backdropPath {
            backdropImageView.downloadImage(from: backdropUrlString)
        }
        
        if let posterUrlString = movie.posterPath {
            posterImageView.downloadImage(from: posterUrlString)
        }
        
        titleLabel.text = movie.originalTitle
        
    }

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.text = "100 minutes"
        label.textColor = .secondaryLabel
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Original Language"
        label.textColor = .label
        return label
    }()
    

    lazy var movieInfoStackView: UIStackView! = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        
        
        sv.addArrangedSubview(titleLabel)
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
            
            posterImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -20),
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
