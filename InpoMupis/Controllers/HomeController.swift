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
    
    var popularMovies: MovieCategory = {
        let mc = MovieCategory(title: "Popular")
        return mc
    }()
    
    var nowPlayingMovies: MovieCategory = {
        let mc = MovieCategory(title: "Now Playing")
        return mc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
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
        

        // Register cell classes
        self.collectionView!.register(CategoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func fetchMovies(withCategory category: String) {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }

    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        switch indexPath.section {
        case 0:
            cell.setCategory(categoryTitle: "Now Playing", movies: nowPlayingMovies.movies)
            cell.delegate = self
        case 1:
            cell.setCategory(categoryTitle: "Popular", movies: popularMovies.movies)
        default:
            cell.setCategory(categoryTitle: "NA", movies: [])
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}

extension HomeController: HomeControllerDelegate {
    func didRequestMovie(movie: Movie?) {        guard let movie = movie else {
            return
        }
        let favVC = FavoritesVC(movie: movie)
        navigationController?.pushViewController(favVC, animated: true)
    }
    
    
}

