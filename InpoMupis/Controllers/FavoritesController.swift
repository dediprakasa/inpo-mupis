//
//  FavoritesController.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/20/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    
    let tableView = UITableView()
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PersistenceManager.getFavorites { result in
            switch result {
            case .success(let movies):
                if movies.isEmpty {
                    self.showEmptyStates(message: "No Favorites", inView: self.view)
                } else {
                    self.movies = movies
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    IMAlert.showAlert(on: self, title: "Oops..", message: error.rawValue)
                }
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.backgroundColor = .systemBackground
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FavoritesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        cell.set(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        let destinationVC = FavoritesVC(movie: selectedMovie)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let selectedMovie = movies[indexPath.row]
        
        PersistenceManager.updateWith(favorite: selectedMovie, actionType: .remove) { error in
            if error != nil {
                IMAlert.showAlert(on: self, title: "Oops..", message: "Unable to remove from Favorites")
                return
            }
            self.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            if self.movies.isEmpty {
                self.showEmptyStates(message: "No Favorites", inView: self.view)
            }
        }
    }
    
    
}
