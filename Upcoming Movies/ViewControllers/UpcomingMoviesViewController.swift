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
    
    let upcomingListViewModel = MovieListViewModel(listType: .Upcoming)
    let nowPlayingListViewModel = MovieListViewModel(listType: .NowPlaying)
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    
    func loadMoreMovies() {
        if movieListViewModel.canLoadMore {
            self.loadingMoreView.startAnimating()
            self.movieListViewModel.updateMovies()
        }
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = LocationManager.moviesTitle
    }
    
    func setupListType() {
        updateListType(sender: self.segmentedControll)
    }
    
    @objc func updateListType(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            self.movieListViewModel = self.nowPlayingListViewModel
        default:
            self.movieListViewModel = self.upcomingListViewModel
        }
        self.movieListViewModel.onMoviesUpdated = { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.onMoviesUpdated()
            }
        }
        self.tableView.reloadData()
        self.loadMoreMovies()
    }
    
    fileprivate func setupSegmentedControll() {
        self.segmentedControll.setTitle(LocationManager.upcomingMoviesTitle, forSegmentAt: 0)
        self.segmentedControll.setTitle(LocationManager.nowPlayingMoviesTitle, forSegmentAt: 1)
        self.segmentedControll.addTarget(self, action: #selector(updateListType(sender:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSegmentedControll()
        self.setupNavigationBar()
        self.setupListType()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UpcomingMoviesViewController.openMovieDetailSegue,
            let detailViewController = segue.destination as? MovieDetailViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            detailViewController.movie = self.movieListViewModel.movies[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.movieListViewModel.movies.count - 1) {
            self.loadMoreMovies()
        }
    }
}
