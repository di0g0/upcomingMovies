//
//  ViewController.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 29/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: MovieListBaseViewController {
    private static let openMovieDetailSegue = "openMovieDetailSegue"
            
    func loadMoreMovies() {
        if movieListViewModel.canLoadMore {
            self.loadingMoreView.startAnimating()
            self.movieListViewModel.updateMovies()
        }
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.title = NSLocalizedString("Upcoming Movies", comment: "")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()                
        self.loadMoreMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UpcomingMoviesViewController.openMovieDetailSegue,
            let detailViewController = segue.destination as? MovieDetailViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            detailViewController.movie = self.movieListViewModel.movies[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.movieListViewModel.movies.count - 1 && self.movieListViewModel.canLoadMore) {
            self.loadMoreMovies()
        }
    }
}
