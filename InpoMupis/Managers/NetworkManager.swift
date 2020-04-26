//
//  NetworkManager.swift
//  InpoMupis
//
//  Created by Dedi Prakasa on 4/19/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

enum MovieCluster {
    static let popular = "popular"
    static let nowPlaying = "now_playing"
}

struct FetchResult: Codable {
    let results: [Movie]
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private let apiKey = "14ab2076da42be9a9bfb79d4b162d799"
    private lazy var baseURL = "https://api.themoviedb.org/3/movie"
    
    private init() {}
    
    func getPopularMovies(completion: @escaping (Result<FetchResult, Error>) -> Void) {
        let endpoint = baseURL + "/\(MovieCluster.popular)?api_key=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(IMError.errorMsg))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(IMError.errorMsg))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(IMError.errorMsg))
                return
            }
            
            guard let data = data else {
                completion(.failure(IMError.errorMsg))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(FetchResult.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(IMError.errorMsg))
            }
        }
        
        task.resume()
    }
    
    func getNowPlayingMovies(completion: @escaping (Result<FetchResult, Error>) -> Void) {
        let endpoint = baseURL + "/\(MovieCluster.nowPlaying)?api_key=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(IMError.errorMsg))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(IMError.errorMsg))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(IMError.errorMsg))
                return
            }
            
            guard let data = data else {
                completion(.failure(IMError.errorMsg))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(FetchResult.self, from: data)
                completion(.success(movies))
            } catch {
                print("-----")
                completion(.failure(IMError.errorMsg))
            }
        }
        
        task.resume()
    }
    
}
