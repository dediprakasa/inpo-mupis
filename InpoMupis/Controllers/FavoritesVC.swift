//
//  FavoritesVC.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/16/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.isUserInteractionEnabled = true
        view.frame = self.view.bounds
        return view
    }()
    
    var movie: Movie!
    let posterImageView = IMMoviePosterImageView(frame: .zero)
    let backdropImageView = IMMovieBackdropImageView(frame: .zero)
    let recommendationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
        
    }()
    var recommendationMovies: MovieCategory = {
        let mc = MovieCategory(title: "Recommendations")
        return mc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        setInfo()
        fetchRecommendations()
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
    }
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchRecommendations() {
        NetworkManager.shared.getRecommendation(for: movie) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.recommendationMovies.setMovies(movies: movies.results)
                    self.recommendationCollectionView.reloadData()
                }
                break
            case .failure(let error):
                if error is IMError {
                    let errorMsg = error as! IMError
                    print(errorMsg.rawValue)
                }
                break
            }
        }
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
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Language: \(movie.originalLanguage!)"
        label.textColor = .secondaryLabel
        return label
    }()
    
    let voteLabel: UILabel = {
        let label = UILabel()
        label.text = "Vote Average"
        label.textColor = .label
        return label
    }()
    
    lazy var voteValueLabel: UILabel = {
        let label = UILabel()
        label.text = String(movie.voteAverage!)
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    

    lazy var movieInfoStackView: UIStackView! = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        
        
        sv.addArrangedSubview(titleLabel)
        sv.addArrangedSubview(languageLabel)
        sv.addArrangedSubview(voteLabel)
        sv.addArrangedSubview(voteValueLabel)
        
        return sv
    }()
    
    lazy var overviewLabelText = movie.overview
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = overviewLabelText
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func getOverviewLabelHeight() -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))

        label.font = UIFont.systemFont(ofSize: 16)
        label.text = overviewLabelText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        return label.frame.height
    }
    
    lazy var overviewContainerView: UIView = {
        let view = UIView()
        let ovLabel = self.overviewLabel
        view.addSubview(ovLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ovLabel.topAnchor.constraint(equalTo: view.topAnchor),
            ovLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ovLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ovLabel.heightAnchor.constraint(equalToConstant: getOverviewLabelHeight())
        ])
        
        return view
    }()
    
    func configureUI() {
        
        
        view.addSubview(scrollView)
        
        
        let addButon = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButon
        
        scrollView.addSubview(backdropImageView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(movieInfoStackView)
        scrollView.addSubview(overviewContainerView)
        scrollView.addSubview(recommendationCollectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            backdropImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5),
            
            posterImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -20),
            posterImageView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 40),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.heightAnchor.constraint(equalToConstant: 210),
//
            movieInfoStackView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 24),
            movieInfoStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            movieInfoStackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            movieInfoStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
//
            overviewContainerView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            overviewContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            overviewContainerView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            overviewContainerView.heightAnchor.constraint(equalToConstant: getOverviewLabelHeight()),
            
            recommendationCollectionView.topAnchor.constraint(equalTo: overviewContainerView.bottomAnchor, constant: 20),
            recommendationCollectionView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            recommendationCollectionView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            recommendationCollectionView.heightAnchor.constraint(equalToConstant: 250)
            
            
        ])
        
    }
    
    
    @objc func addButtonTapped() {
        PersistenceManager.updateWith(favorite: movie, actionType: .add) { error in
                
            guard let error = error else {
                IMAlert.showAlert(on: self, title: "Success", message: "Successfully added")
                return
            }
            print(error.localizedDescription)
            IMAlert.showAlert(on: self, title: "Oops..", message: error.rawValue)
        }
    }


}

extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeControllerDelegate {
    func didRequestMovie(movie: Movie?) {
        guard let movie = movie else {
            return
        }
        let favVC = FavoritesVC(movie: movie)
        navigationController?.pushViewController(favVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.setCategory(categoryTitle: "Recommendations", movies: recommendationMovies.movies)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
    
    
    
}
