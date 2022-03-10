//
//  DetailViewController.swift
//  TMDBSampleApp
//
//  Created by appcent on 10.03.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var vm : DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm?.delegate = self
        vm.fetchMovieDetail()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func didGetMovieDetail() {
        if let desc = vm?.movieDetail?.overview {
            textView.text = desc
        }
        fetchImage()
    }
    
    func spinnerStart() {
        spinner.startAnimating()
    }
    
    func spinnerStop() {
        spinner.stopAnimating()
    }
}

extension DetailViewController {
    private func fetchImage() {
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(vm.movieDetail?.posterPath ?? "")")
        imageView.kf.setImage(with: url)
    }
}
