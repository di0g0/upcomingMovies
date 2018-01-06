//
//  ConfigServices.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 06/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

struct ConfigResponse {
    let imageBaseUrl: String
    init(imageBaseUrl: String) {
        self.imageBaseUrl = imageBaseUrl
    }
}

struct GenreListResponse {
    let genreList: [JSONObject]
    init(genreList: [JSONObject]) {
        self.genreList = genreList
    }
}

class ConfigServices : APIClient {
    class func getConfig(completion:@escaping ((Result<ConfigResponse>) -> Void)) {
        request(urlPath: Constants.API.configPath, params: nil) { (responseJSON, error) in
            guard let response = responseJSON,
                let imagesConfig = response[Constants.ResponseParams.images] as? JSONObject,
                let imageBaseUrl = imagesConfig[Constants.ResponseParams.imageBaseUrl] as? String
                else {
                    completion(.Failure(error ?? APIClientError.jsonParsingError))
                    return
            }
            
            completion(.Success(ConfigResponse(imageBaseUrl: imageBaseUrl)))
        }
    }
    
    class func getGenreList(completion:@escaping ((Result<GenreListResponse>) -> Void)) {
        request(urlPath: Constants.API.genresPath, params: nil) { (responseJSON, error) in
            guard let response = responseJSON,
                let jsonList = response[Constants.ResponseParams.genres] as? [JSONObject] else {
                    completion(.Failure(error ?? APIClientError.jsonParsingError))
                    return
            }
            
            completion(.Success(GenreListResponse(genreList: jsonList)))
        }
    }
}
