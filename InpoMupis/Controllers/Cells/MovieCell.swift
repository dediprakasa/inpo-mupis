//
//  MovieCell.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let movieImageView = IMMoviePosterImageView(frame: .zero)
    var movieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
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
    
    private func configureViews() {
        
        backgroundColor = .clear
        
        addSubview(movieImageView)
        addSubview(movieLabel)
        
        movieImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width * 1.48)
        movieLabel.frame = CGRect(x: 0, y: movieImageView.frame.height, width: frame.width, height: 40)
        
    }
    
    func set(movie: Movie!) {
        movieLabel.text = movie.originalTitle
        guard let posterPath = movie.posterPath else {
            return
        }
        movieImageView.downloadImage(from: posterPath)
    }
    
    
}
