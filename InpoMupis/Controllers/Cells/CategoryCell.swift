//
//  CategoryCell.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    private let reuseID = "movieCell"
    var movies: [Movie]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
        
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setMovies(movies: [Movie]) {
        self.movies = movies
        movieCollectionView.reloadData()
    }
    
    func configureViews() {
        backgroundColor = .clear
        
        addSubview(categoryLabel)
        addSubview(movieCollectionView)
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: reuseID)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            movieCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            movieCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            movieCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
        ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
}

extension CategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = self.movies else {
            return 0
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! MovieCell
        cell.set(movie: movies?[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height - 20)
    }
}


