//
//  SearchCell.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 5/1/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    static let reuseID = "SearchCell"
    
    let movieImageView = IMMoviePosterImageView(frame: .zero)
    var movieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
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

        
        addSubview(movieImageView)
        addSubview(movieLabel)
        
        let padding: CGFloat = 10
//        movieImageView.frame = CGRect(x: padding/2, y: 0, width: frame.width - padding, height: (frame.width - padding) * 1.48)
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            
            movieLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5),
            movieLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
//        movieLabel.frame = CGRect(x: 10, y: movieImageView.frame.height, width: frame.width, height: 40)
        
    }
    
    func set(movie: Movie!) {
        movieLabel.text = movie.originalTitle
        guard let posterPath = movie.posterPath else {
            return
        }
        movieImageView.downloadImage(from: posterPath)
    }
}
