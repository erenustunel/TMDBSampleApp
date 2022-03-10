//
//  NetworkManager.swift
//  TMBDMoovie
//
//  Created by appcent on 8.03.2022.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func fetchPopularMovies(completion: @escaping (Result<MovieResponse, Error>) -> ())
    func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])

    func fetchPopularMovies(completion: @escaping (Result<MovieResponse, Error>) -> ()) {
        request(target: API.popular, completion: completion)
    }
    
    func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> ()) {
        request(target: API.movie(movieId: movieId), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
