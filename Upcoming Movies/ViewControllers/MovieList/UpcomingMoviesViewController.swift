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
    
    @IBOutlet weak var toolbar: UIToolbar! {
        didSet {
            toolbar.delegate = self
        }
    }
    let upcomingListViewModel = MovieListViewModel(listType: .Upcoming)
    let nowPlayingListViewModel = MovieListViewModel(listType: .NowPlaying)
    let popularListViewModel = MovieListViewModel(listType: .Popular)
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
        
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
        case 0:
            self.movieListViewModel = self.popularListViewModel
        case 1:
            self.movieListViewModel = self.nowPlayingListViewModel
        default:
            self.movieListViewModel = self.upcomingListViewModel
        }
        self.movieListViewModel.onMoviesUpdated = { [weak self] (error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print (error)
            }
            DispatchQueue.main.async {
                strongSelf.onMoviesUpdated()
            }
        }
        self.tableView.reloadData()
        self.loadMoreMovies()
    }
    
    fileprivate func setupSegmentedControll() {        
        self.segmentedControll.setTitle(LocationManager.popularMoviesTitle, forSegmentAt: 0)
        self.segmentedControll.setTitle(LocationManager.nowPlayingMoviesTitle, forSegmentAt: 1)
        self.segmentedControll.setTitle(LocationManager.upcomingMoviesTitle, forSegmentAt: 2)
        
        self.segmentedControll.addTarget(self, action: #selector(updateListType(sender:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSegmentedControll()
        self.setupNavigationBar()
        self.setupListType()
    }    
}

extension UpcomingMoviesViewController: UIToolbarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
