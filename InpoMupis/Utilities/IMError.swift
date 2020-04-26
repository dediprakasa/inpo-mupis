//
//  IMError.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/19/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import Foundation

enum IMError: String, Error {
    case errorMsg = "Something went wrong"
    case unableToGetFavorites = "Something went wrong on retrieving favorites data"
    case alreadyInFavorites = "You have favorited this movie"
    case unableToFavorite = "Something went wrong. Unable to favorite this movie"
}
