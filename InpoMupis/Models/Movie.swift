//
//  Movie.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/19/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

struct Movie: Codable, Hashable {
    var posterPath: String?
    let originalTitle: String
    var backdropPath: String?
    var overview: String?
}
