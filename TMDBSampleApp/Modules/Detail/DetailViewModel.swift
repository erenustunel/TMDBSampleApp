//
//  DetailViewModel.swift
//  TMDBSampleApp
//
//  Created by appcent on 10.03.2022.
//

import Foundation
import Moya
import Kingfisher

protocol DetailViewModelDelegate: AnyObject {
    func didGetMovieDetail()
    func spinnerStart()
    func spinnerStop()
}

class DetailViewModel {
    weak var delegate: DetailViewModelDelegate?
    fileprivate(set) var movieDetail: MovieDetailResponse?
    private let networkManager: NetworkManager
    private var movieId : Int?

    init(networkManager: NetworkManager = NetworkManager(),_ movieId: Int) {
        self.networkManager = networkManager
        self.movieId = movieId
    }

    func fetchMovieDetail() {
        delegate?.spinnerStart()
        networkManager.fetchMovieDetail(movieId: "\(movieId ?? 0)") { [weak self] results in
            guard let self = self else {return}
            switch results {
            case .success(let response):
                self.movieDetail = response
                self.delegate?.didGetMovieDetail()
                self.delegate?.spinnerStop()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
