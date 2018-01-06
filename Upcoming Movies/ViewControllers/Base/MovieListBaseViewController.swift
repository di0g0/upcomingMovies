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
}

class MovieListBaseViewController : UIViewController, MovieListBaseViewControllerDelegate {
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
        self.movieListViewModel.onMoviesUpdated = { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.onMoviesUpdated()
            }
        }
    }
}
