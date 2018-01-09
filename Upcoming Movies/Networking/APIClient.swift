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

enum APIClientError: Error {
    case jsonParsingError
    case other
}

public enum Result<T> {
    case Failure(Error)
    case Success(T)
}

class APIClient {
    private static let apiKey = "c4fc48ad9f20ea3972c007ee1528fae2"
    private static let defaultParams:JSONObject = [
        Constants.RequestParams.apiKey : apiKey,
        Constants.RequestParams.language:LocationManager.lang,
        Constants.RequestParams.region:LocationManager.region,
        ]
        
    class func request(urlPath:String, params:JSONObject?, completion: @escaping ((JSONObject?, Error?) -> Void)) {
        let url = Constants.API.apiBaseURL + urlPath
        var requestParams = self.defaultParams
        requestParams.append(dictionary: params)
        
        Alamofire.request(url, method: .get, parameters: requestParams).responseJSON { (response) in
            guard let responseJSON = response.result.value as? JSONObject
                else {
                    completion(nil,APIClientError.jsonParsingError)
                    return
            }
            
            completion(responseJSON,nil)
        }
    }
}
