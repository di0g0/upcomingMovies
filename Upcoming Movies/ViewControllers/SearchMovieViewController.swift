//
//  SearchMovieViewController.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 02/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import UIKit
class SearchMovieViewController: MovieListBaseViewController {
    private static let openMovieDetailSegue = "searchMovieToDetailSegue"
    
    var keyboardTimer: Timer?
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("Search movies", comment: "")
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private func setupSearchBar() {        
        self.searchBar.delegate = self
        self.navigationItem.titleView = self.searchBar
        self.searchBar.becomeFirstResponder()
    }
    
    @objc func searchMovies(timer: Timer) {
        if let text = timer.userInfo as? String {
            self.movieListViewModel.searchMovies(searchQuery: text)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.keyboardTimer?.invalidate()
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = " "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()        
        self.setupSearchBar()        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.searchBar.resignFirstResponder()
        if segue.identifier == SearchMovieViewController.openMovieDetailSegue,
            let detailViewController = segue.destination as? MovieDetailViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            detailViewController.movie = self.movieListViewModel.movies[indexPath.row]
        }
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyboardTimer?.invalidate()
        
        if searchText.count > 0 {
            self.keyboardTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(searchMovies(timer:)), userInfo: searchText, repeats: false)
        } else {
            self.movieListViewModel.movies.removeAll()            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
