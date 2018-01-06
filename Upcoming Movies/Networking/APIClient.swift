//
//  APIClient.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 30/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONObject = [String : Any]

class APIClient {
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    private static let defaultParams:JSONObject = [
        Constants.RequestParams.apiKey : apiKey,
        Constants.RequestParams.language:LocationManager.lang,
        Constants.RequestParams.region:LocationManager.region,
        ]
    
    class func getConfig(completion:@escaping ((String?, Bool) -> Void)) {
        let url = Constants.API.apiBaseURL + Constants.API.configPath
        
        Alamofire.request(url, method: .get, parameters: defaultParams).responseJSON { (response) in
            guard let responseJSON = response.result.value as? JSONObject,
                let imagesConfig = responseJSON[Constants.ResponseParams.images] as? JSONObject,
                let imageBaseUrl = imagesConfig[Constants.ResponseParams.imageBaseUrl] as? String
                else {
                    completion(nil,false)
                    return
            }
            completion(imageBaseUrl, true)
        }
    }
    
    class func getGenreList(completion:@escaping (([JSONObject]?,Bool) -> Void)) {
        let url = Constants.API.apiBaseURL + Constants.API.genresPath
        let params = defaultParams
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            guard let responseJSON = response.result.value as? JSONObject,
                let jsonList = responseJSON[Constants.ResponseParams.genres] as? [JSONObject] else {
                    completion(nil,false)
                    return
            }
            
            completion(jsonList,true)
        }
    }
    
    class func upcomingMovies(with page:Int, completion:@escaping (([JSONObject], Bool) -> Void)) {
        let url = Constants.API.apiBaseURL + Constants.API.upcomingPath
        var params = defaultParams
        params[Constants.RequestParams.page] = page
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            guard let responseJSON = response.result.value as? JSONObject,
                let jsonArray = responseJSON[Constants.ResponseParams.results] as? [JSONObject],
                let totalPages = responseJSON[Constants.ResponseParams.totalPages] as? Int
                else {
                    return
            }
                        
            completion(jsonArray, (page < totalPages))
        }
    }
    
    class func searchMovies(with term:String, page:Int, completion:@escaping (([JSONObject], Bool) -> Void)) {
        let url = Constants.API.apiBaseURL + Constants.API.searchPath
        var params = defaultParams
        params[Constants.RequestParams.query] = term
        params[Constants.RequestParams.page] = page
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            guard let responseJSON = response.result.value as? JSONObject,
                let jsonArray = responseJSON[Constants.ResponseParams.results] as? [JSONObject],
                let totalPages = responseJSON[Constants.ResponseParams.totalPages] as? Int
                else {
                    return
            }
            
            completion(jsonArray, (page < totalPages))
        }
    }
}
