//
//  MovieServices.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 06/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

struct PagedMovieResponse {
    let movieList:[JSONObject]
    let totalPages:Int
    
    init(movieList:[JSONObject],totalPages:Int) {
        self.movieList = movieList
        self.totalPages = totalPages
    }
}

class MovieServices : APIClient {
    private class func getMovieList(with path:String, query:String?, page:Int, completion:@escaping ((Result<PagedMovieResponse>) -> Void)) {
        let params = [
            Constants.RequestParams.page : page,
            Constants.RequestParams.query : query ?? ""
            ] as JSONObject
        
        request(urlPath: path, params: params) { (responseJSON, error) in            
            guard let response = responseJSON,
                let jsonArray = response[Constants.ResponseParams.results] as? [JSONObject],
                let totalPages = response[Constants.ResponseParams.totalPages] as? Int
                else {
                    completion(.Failure(error ?? APIClientError.jsonParsingError))
                    return
            }
            let movieResponse = PagedMovieResponse(movieList: jsonArray, totalPages: totalPages)
            completion(.Success(movieResponse))
        }
    }
        
    class func getMovies(with listType:MovieListType, page:Int, completion:@escaping ((Result<PagedMovieResponse>) -> Void)) {
        getMovieList(with: listType.getURLPath(), query: nil, page: page, completion: completion)
    }
    
    class func searchMovies(with term:String, page:Int, completion:@escaping ((Result<PagedMovieResponse>) -> Void)) {
        getMovieList(with: Constants.API.searchPath, query: term,page: page, completion: completion)
    }
}
