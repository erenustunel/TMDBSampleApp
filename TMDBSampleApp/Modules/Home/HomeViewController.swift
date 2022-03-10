//
//  ViewController.swift
//  TMBDMoovie
//
//  Created by appcent on 5.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    private var vm = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm.delegate = self
        vm.fetchMovies()
        registerTableView()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didGetMovies() {
        tableView.reloadData()
    }

    func spinnerStart() {
        activityIndicator.startAnimating()
    }

    func spinnerStop() {
        activityIndicator.stopAnimating()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.popularMovies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        if let movies = vm.popularMovies {
            cell.setCell(movie: movies[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let goToDetailVC = storyBoard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
                goToDetailVC.vm = DetailViewModel(vm.popularMovies?[indexPath.row].id ?? 0)
                self.present(goToDetailVC, animated: true, completion: nil)
    }
}

extension HomeViewController {
    func registerTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerCells([HomeCell.self])
    }
}
