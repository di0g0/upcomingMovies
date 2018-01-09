//
//  MovieViewModel.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 30/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import Foundation
class MovieViewModel {
    private var movie: Movie {
        didSet {
            self.onMovieUpdated?()
        }
    }
    
    var onMovieUpdated: (()->())?
    
    var directorName: String? {
        return movie.director?.name.capitalized
    }
    
    var cast:[CastPersonViewModel] {
        let castVMs:[CastPersonViewModel] = movie.cast.map {CastPersonViewModel(person:$0)}
        return castVMs
    }
    
    var id:Int {
        return movie.identifier
    }
    
    var title:String {
        return movie.title.capitalized
    }
    
    var originalTitle: String? {
        return movie.originalTitle?.capitalized
    }
    
    var overview:String {
        return movie.overview
    }
    
    var backdropUrl:URL? {
        return ImageManager.backdropImageUrl(with: movie.backdropUrl)
    }
    
    var pictureUrl:URL? {
        return ImageManager.posterImageUrl(with: movie.posterUrl)
    }
    
    init(movie:Movie) {
        self.movie = movie
    }
    
    var avgRatingString: String {
        guard let rating = self.movie.avgRating else {
            return "--"
        }
        
        return String(format: "%.1f", rating)
    }
    
    var yearString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy"
        return dateFormater.string(from: self.movie.releaseDate)
    }
    
    var timeString: String? {
        guard let time = self.movie.runTime else {return nil}
        return "\(time) min."
    }
    
    var releaseDateString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater.string(from: self.movie.releaseDate)
    }
    
    var genreListString:String {
        let genres = GenreManager.genreList.filter {movie.genreIds.contains($0.identifier)}
        let stringArray = genres.map{$0.name}
        let string = stringArray.joined(separator: ", ")
        
        return string
    }
    
    func getDetails() {
        MovieServices.getDetail(for: movie.identifier) {[weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case let .Failure(error):
                print(error)
            case let .Success(movieResponse):
                strongSelf.movie.updateWith(jsonObject: movieResponse.movieJson)
            }
        }
    }
}
