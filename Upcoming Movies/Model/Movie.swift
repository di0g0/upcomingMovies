//
//  Movie.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 03/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import Foundation
struct Movie {
    let identifier:Int64
    let title:String
    let overview:String
    let releaseDate:Date
    let originalTitle:String?
    let posterUrl:String?
    let backdropUrl:String?
    
    let genreIds:[Int]
    
    init(identifier:Int64, title: String, overview: String, date: Date, originalTitle: String?, posterUrl: String?, backdropUrl:String?, genreIds:[Int]) {
        self.identifier = identifier
        self.title = title
        self.overview = overview
        self.originalTitle = originalTitle
        self.posterUrl = posterUrl
        self.backdropUrl = backdropUrl
        self.releaseDate = date
        self.genreIds = genreIds
    }
    
    static func fromJson(jsonObject: [String:Any]) -> Movie? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = Constants.API.dateFormat
        
        guard let identifier = jsonObject[Constants.ResponseParams.id] as? Int64,
            let title = jsonObject[Constants.ResponseParams.title] as? String,
            let overview = jsonObject[Constants.ResponseParams.overview] as? String,
            let dateString = jsonObject[Constants.ResponseParams.releaseDate] as? String,
            let date = dateFormater.date(from: dateString),
            let genreIds = jsonObject[Constants.ResponseParams.genreIds] as? [Int]
            else {
                return nil
        }
        
        let posterUrl = jsonObject[Constants.ResponseParams.posterPath] as? String
        let backdropImageUrl = jsonObject[Constants.ResponseParams.backdrop] as? String
        let originalTitle = jsonObject[Constants.ResponseParams.originalTitle] as? String
        
        let movie = Movie(identifier: identifier, title: title, overview:overview, date: date, originalTitle: originalTitle, posterUrl: posterUrl, backdropUrl: backdropImageUrl, genreIds:genreIds)
        
        return movie
    }
}

