//
//  PersistenceManager.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/26/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

class PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Movie, actionType: PersistenceActionType, completion: @escaping (IMError?) -> Void) {
        getFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType  {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll { $0.originalTitle == favorite.originalTitle }
                }
                
                completion(save(favorites: retrievedFavorites))
            case .failure(let error):
                completion(error)
            }
        }
        
        
    }
    
    static func getFavorites(completion: @escaping (Result<[Movie], IMError>) -> Void) {
        
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Movie].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToGetFavorites))
        }

    }
    
    static func save(favorites: [Movie]) -> IMError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
