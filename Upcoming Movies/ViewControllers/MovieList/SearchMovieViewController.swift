//
//  SearchMovieViewController.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 02/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import UIKit
class SearchMovieViewController: MovieListBaseViewController {        
    var keyboardTimer: Timer?
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = LocationManager.searchMoviesPlaceholder        
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
            self.loadingMoreView.startAnimating()
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
        self.movieListViewModel.listType = .Search
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
        super.prepare(for: segue, sender: sender)
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyboardTimer?.invalidate()
        
        if searchText.count > 0 {
            self.keyboardTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(searchMovies(timer:)), userInfo: searchText, repeats: false)
        } else {
            self.movieListViewModel.resetList()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
