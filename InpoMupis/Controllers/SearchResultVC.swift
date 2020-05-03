//
//  SearchResultVC.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/29/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController {
    
    var collectionView: UICollectionView!
    var movies: [Movie] = []
    var delegate: HomeControllerDelegate!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnsFlowLayout(in: self.view))
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.reuseID)
        
        view.addSubview(collectionView)
    }
    

}

extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.reuseID, for: indexPath) as! SearchCell
        cell.set(movie: movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetVC = FavoritesVC(movie: movies[indexPath.row])
        navigationController?.pushViewController(targetVC, animated: true)
        
    }
    
}
