//
//  MovieListViewModel.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 04/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

enum MovieListType {
    case Search
    case Upcoming
    case NowPlaying
    case Popular
    
    func getURLPath() -> String {
        switch self {
        case .Upcoming:
            return Constants.API.upcomingPath
        case .NowPlaying:
            return Constants.API.nowPlayingPath
        case .Search:
            return Constants.API.searchPath
        case .Popular:
            return Constants.API.popularPath
        }
    }
    
    func getViewTitle() -> String {
        switch self {
        case .Upcoming:
            return LocationManager.upcomingMoviesTitle
        case .NowPlaying:
            return LocationManager.nowPlayingMoviesTitle
        case .Search:
            return LocationManager.searchMoviesPlaceholder
        case .Popular:
            return LocationManager.popularMoviesTitle
        }
    }
}

class MovieListViewModel {
    private var currentPage = 0
    var canLoadMore = true
    
    var searchQuery: String?
    var onMoviesUpdated: ((Error?)->())?
    var listType:MovieListType
    
    init(listType: MovieListType) {
        self.listType = listType
    }
    
    func resetList() {
        self.movies.removeAll()
        self.currentPage = 0
        self.canLoadMore = true
    }
    
    internal var movies:[MovieViewModel] = [MovieViewModel]() {
        didSet{
            self.onMoviesUpdated?(nil)
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
        MovieServices.getMovies(with: self.listType, query: self.searchQuery, page: self.currentPage) {[weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case let .Failure(error):
                strongSelf.onMoviesUpdated?(error)
            case let .Success(pagedResponse):
                strongSelf.canLoadMore = (strongSelf.currentPage < pagedResponse.totalPages)
                strongSelf.movies += strongSelf.parseMoviesFrom(jsonResponse: pagedResponse.movieList)
            }
        }
    }
    
    func searchMovies(searchQuery:String) {
        self.searchQuery = searchQuery
        self.resetList()
        self.updateMovies()
    }
}
