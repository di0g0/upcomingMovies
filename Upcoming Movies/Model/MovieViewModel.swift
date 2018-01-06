//
//  MovieViewModel.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 30/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import Foundation
struct MovieViewModel {
    private let movie: Movie
    
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
}
