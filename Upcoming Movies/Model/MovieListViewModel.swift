//
//  MovieListViewModel.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 04/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

class MovieListViewModel {
    private var currentPage = 0
    var canLoadMore = true
    
    var onMoviesUpdated: (()->())?
    
    internal var movies:[MovieViewModel] = [MovieViewModel]() {
        didSet{
            self.onMoviesUpdated?()
        }
    }
    
    func parseMoviesFrom(jsonResponse: [JSONObject]) -> [MovieViewModel] {
        var vms = [MovieViewModel]()
        for obj in jsonResponse {
            guard let movie = Movie.fromJson(jsonObject: obj) else {
                continue
            }
            vms.append(MovieViewModel(movie: movie))
        }
        return vms
    }
    
    func updateMovies() {
        self.currentPage = self.currentPage + 1        
        MovieServices.upcomingMovies(with: self.currentPage) { [weak self](response) in
            guard let strongSelf = self else { return }
            switch response {
            case let .Failure(error):
                print(error)                
            case let .Success(pagedResponse):
                strongSelf.canLoadMore = (strongSelf.currentPage < pagedResponse.totalPages)
                strongSelf.movies += strongSelf.parseMoviesFrom(jsonResponse: pagedResponse.movieList)
            }
        }
    }
    
    func searchMovies(searchQuery:String) {
        MovieServices.searchMovies(with: searchQuery, page: 1) {[weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case let .Failure(error):
                print(error)
            case let .Success(pagedResponse):
                strongSelf.movies = strongSelf.parseMoviesFrom(jsonResponse: pagedResponse.movieList)
            }
        }
    }
}
