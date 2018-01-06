//
//  MovieListViewControllerTableViewExtensions.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 04/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//
import UIKit
extension MovieListBaseViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }        
}

extension MovieListBaseViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieListViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier, for: indexPath) as! MovieListCell
        let movie = self.movieListViewModel.movies[indexPath.row]
        cell.fill(with: movie)
        return cell
    }
}
