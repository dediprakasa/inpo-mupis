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
    
    let overviewLabelText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
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
        print(ovLabel.frame.height)
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
            overviewContainerView.heightAnchor.constraint(equalToConstant: getOverviewLabelHeight())
            
            
        ])
        
        print(scrollView.frame.size, "+++")
        print(scrollView.contentSize, "---")
        
    }
    
    @objc func addButtonTapped() {
        print("----")
    }


}
