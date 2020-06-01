//
//  HomeController.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol HomeControllerDelegate: class {
    func didRequestMovie(movie: Movie?)
}

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
    let searchResultVC: SearchResultVC = {
        let vc = SearchResultVC()
        vc.view.backgroundColor = .systemYellow

        return vc
    }()
    
    var popularMovies: MovieCategory = {
        let mc = MovieCategory(title: "Popular")
        return mc
    }()
    
    var nowPlayingMovies: MovieCategory = {
        let mc = MovieCategory(title: "Now Playing")
        return mc
    }()
    
    var upcomingMovies: MovieCategory = {
        let mc = MovieCategory(title: "Upcoming")
        return mc
    }()
    
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        configureSearchController()
        fetchNowPlayingMovies()
        fetchPopularMovies()
        fetchUpcomingMovies()
        

        // Register cell classes
        self.collectionView!.register(CategoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a movie"
        searchController.searchBar.endEditing(true)
        navigationItem.searchController = searchController
    }
    
    func fetchNowPlayingMovies() {
        NetworkManager.shared.getNowPlayingMovies { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.nowPlayingMovies.setMovies(movies: movies.results)
                    self.collectionView.reloadData()
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
    
    func fetchPopularMovies() {
        NetworkManager.shared.getPopularMovies { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.popularMovies.setMovies(movies: movies.results)
                    self.collectionView.reloadData()
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
    
    func fetchUpcomingMovies() {
        NetworkManager.shared.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.upcomingMovies.setMovies(movies: movies.results)
                    self.collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }

    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        switch indexPath.section {
        case 0:
            cell.setCategory(categoryTitle: "Now Playing", movies: nowPlayingMovies.movies)
        case 1:
            cell.setCategory(categoryTitle: "Popular", movies: popularMovies.movies)
        case 2:
            cell.setCategory(categoryTitle: "Upcoming", movies: upcomingMovies.movies)
        default:
            cell.setCategory(categoryTitle: "NA", movies: [])
        }
        cell.delegate = self
        return cell
    }
}

extension HomeController: HomeControllerDelegate {
    func didRequestMovie(movie: Movie?) {
        guard let movie = movie else {
            return
        }
        let favVC = FavoritesVC(movie: movie)
        navigationController?.pushViewController(favVC, animated: true)
    }
}

extension HomeController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResultVC.delegate = self
        addChild(searchResultVC)
        view.addSubview(searchResultVC.view)
        
        NetworkManager.shared.searchMovie(for: searchBar.text ?? "") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.searchResultVC.movies = movies.results
                    self.searchResultVC.collectionView.reloadData()
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
        
        
        
        searchResultVC.view.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height - searchBar.frame.height)
        
        UIView.animate(withDuration: 0.3) {
            self.searchResultVC.view.frame.origin.y = searchBar.frame.height
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.searchResultVC.view.frame.origin.y = self.view.frame.height
        }) { _ in
            self.searchResultVC.removeFromParent()
            self.searchResultVC.view.removeFromSuperview()
        }
        
    }
    
}

