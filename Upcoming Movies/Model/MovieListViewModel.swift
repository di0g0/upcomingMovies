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
    
    init(tabBarIndex:Int) {
        switch tabBarIndex {
        case 0:
            self = .Upcoming
        case 1:
            self = .NowPlaying                
        default:
            self = .Upcoming
        }
    }
    
    func getURLPath() -> String {
        switch self {
        case .Upcoming:
            return Constants.API.upcomingPath
        case .NowPlaying:
            return Constants.API.nowPlayingPath
        case .Search:
            return Constants.API.searchPath
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
        }
    }
}

class MovieListViewModel {
    private var currentPage = 0
    var canLoadMore = true
    
    var onMoviesUpdated: (()->())?
    let listType:MovieListType
    
    init(listType: MovieListType) {
        self.listType = listType
    }
    
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
        MovieServices.getMovies(with: self.listType, page: self.currentPage) { [weak self](response) in
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
