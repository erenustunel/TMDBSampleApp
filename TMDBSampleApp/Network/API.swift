//
//  API.swift
//  MoyaSample
//
//  Created by Eren Üstünel on 5/03/2022.
import Moya
import Foundation

import Moya

enum API {
    case popular
    case movie(movieId: String)
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .movie(let movieId):
            return "movie/\(movieId)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular, .movie:
            return .requestParameters(parameters: ["api_key": Constants.API.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
