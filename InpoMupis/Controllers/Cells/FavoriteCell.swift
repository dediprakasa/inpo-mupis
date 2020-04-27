//
//  FavoriteCell.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/27/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    var movies: [Movie] = []
    let moviePoster = IMMoviePosterImageView(frame: .zero)
    let movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        accessoryType = .disclosureIndicator
        
        addSubview(moviePoster)
        addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            moviePoster.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            moviePoster.widthAnchor.constraint(equalToConstant: 50),
            moviePoster.heightAnchor.constraint(equalToConstant: 70),
            
            movieTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            movieTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func set(movie: Movie) {
        movieTitle.text = movie.originalTitle
        guard let posterPath = movie.posterPath else {
            return
        }
        
        moviePoster.downloadImage(from: posterPath)
    }
}
