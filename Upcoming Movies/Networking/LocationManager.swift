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
    static let upcomingMoviesTitle = NSLocalizedString("Upcoming Movies", comment: "")
    static let nowPlayingMoviesTitle = NSLocalizedString("Now In Theaters", comment: "")
    static let moviesTitle = NSLocalizedString("Movies Title", comment: "")
}
