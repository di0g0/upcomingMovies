//
//  Constants.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 02/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

struct Constants {
    struct API {
        internal static let apiBaseURL = "https://api.themoviedb.org/3"        
        internal static let upcomingPath = "/movie/upcoming"
        internal static let movieDetailPath = "/movie/"
        internal static let genresPath = "/genre/movie/list"
        internal static let configPath = "/configuration"
        internal static let searchPath = "/search/movie"
        internal static let dateFormat = "yyyy-MM-dd"
    }
    
    struct RequestParams {
        internal static let apiKey = "api_key"
        internal static let page = "page"
        internal static let language = "language"
        internal static let region = "region"
        internal static let query = "query"
        internal static let movieId = "movie_id"
        internal static let append = "append_to_response"
        internal static let videosAndImages = "videos,images"
    }
    
    struct ResponseParams {
        internal static let results = "results"
        internal static let genres = "genres"
        internal static let images = "images"
        internal static let totalPages = "total_pages"
        internal static let imageBaseUrl = "secure_base_url"
        internal static let id = "id"
        internal static let name = "name"
        internal static let genreIds = "genre_ids"
        internal static let title = "title"
        internal static let posterPath = "poster_path"
        internal static let overview = "overview"
        internal static let backdrop = "backdrop_path"
        internal static let releaseDate = "release_date"
        internal static let originalTitle = "original_title"
    }
}
