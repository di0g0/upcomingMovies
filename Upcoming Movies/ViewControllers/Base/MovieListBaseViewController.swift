//
//  MovieListBaseViewController.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 04/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import UIKit

protocol MovieListBaseViewControllerDelegate {
    func onMoviesUpdated()
    func loadMoreMovies()
}

class MovieListBaseViewController : UIViewController, MovieListBaseViewControllerDelegate {
    static let openMovieDetailSegue = "openMovieDetailSegue"
    
    func loadMoreMovies() {
        if movieListViewModel.canLoadMore {
            self.loadingMoreView.startAnimating()
            self.movieListViewModel.updateMovies()
        }
    }
    
    func onMoviesUpdated() {
        self.loadingMoreView.stopAnimating()
        self.tableView.reloadData()
    }
    
    @IBOutlet weak var loadingMoreView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var movieListViewModel:MovieListViewModel = MovieListViewModel(listType: .Upcoming)
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = MovieListCell.movieCellHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.tableView.register(UINib.init(nibName: MovieListCell.identifier,
                                           bundle: Bundle.main),
                                forCellReuseIdentifier: MovieListCell.identifier)
        
        self.movieListViewModel.onMoviesUpdated = { [weak self] (error)in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.onMoviesUpdated()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == MovieListBaseViewController.openMovieDetailSegue,
            let detailViewController = segue.destination as? MovieDetailViewController,
            let indexPath = self.tableView.indexPathForSelectedRow else { return }
        detailViewController.movie = self.movieListViewModel.movies[indexPath.row]
    }
}
