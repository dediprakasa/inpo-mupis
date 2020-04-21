//
//  MovieCategory.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/21/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class MovieCategory {
    
    let categoryTitle: String?
    var movies: [Movie] = []
    
    init(title: String) {
        self.categoryTitle = title
    }
    
    func setMovies(movies: [Movie]!) {
        guard let movies = movies else {
            return
        }
        self.movies.append(contentsOf: movies)
    }
}
