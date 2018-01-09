//
//  LocationManager.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 06/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import Foundation
struct LocationManager {
    static let lang = Locale.preferredLanguages[0]
    static let region = Locale.current.regionCode ?? ""
    
    static let searchMoviesPlaceholder = NSLocalizedString("Search movies", comment: "")
    static let upcomingMoviesTitle = NSLocalizedString("Upcoming", comment: "")
    static let popularMoviesTitle = NSLocalizedString("Popular", comment: "")
    static let nowPlayingMoviesTitle = NSLocalizedString("Now In Theaters", comment: "")
    static let moviesTitle = NSLocalizedString("Movies Title", comment: "")
    
    static let genre = NSLocalizedString("Genre", comment: "")
    static let releaseDate = NSLocalizedString("Release date", comment: "")
    static let originalTitle = NSLocalizedString("Original Title", comment: "")
    static let overview = NSLocalizedString("Overview", comment: "")
    static let cast = NSLocalizedString("Cast", comment: "")
    static let director = NSLocalizedString("Director", comment: "")
    static let details = NSLocalizedString("Details", comment: "")
    static let watchTrailer = NSLocalizedString("Watch Trailer", comment: "")
    
}
