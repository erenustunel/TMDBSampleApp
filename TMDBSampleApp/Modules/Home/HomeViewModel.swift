//
//  HomeViewModel.swift
//  TMBDMoovie
//
//  Created by appcent on 5.03.2022.
//

import Foundation
import Moya

protocol HomeViewModelDelegate: AnyObject {
    func didGetMovies()
    func spinnerStart()
    func spinnerStop()
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    fileprivate(set) var popularMovies: [MovieResult]? = []
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() {
        delegate?.spinnerStart()
        networkManager.fetchPopularMovies { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                if let movies = response.results {
                    self.popularMovies = movies
                    self.delegate?.didGetMovies()
                    self.delegate?.spinnerStop()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
