//
//  Movie.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 03/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import Foundation

struct CastPerson {
    let identifier:Int
    let character:String?
    let name:String
    let profilePicturePath:String?
    
    init(identifier:Int, character: String?, name:String, profileUrl:String?) {
        self.identifier = identifier
        self.character = character
        self.name = name
        self.profilePicturePath = profileUrl
    }
    
    init?(jsonObject: JSONObject) {
        guard let id = jsonObject[Constants.ResponseParams.id] as? Int,
            let name = jsonObject[Constants.ResponseParams.name] as? String
            else {
                return nil
        }
        
        let pictureUrl = jsonObject[Constants.ResponseParams.profilePath] as? String
        let character = jsonObject[Constants.ResponseParams.character] as? String
        
        self.init(identifier: id, character: character, name:name, profileUrl: pictureUrl)
    }
}

struct CastPersonViewModel {
    private let person: CastPerson
    
    init(person: CastPerson) {
        self.person = person
    }
    var name: String {
        return person.name.capitalized
    }
    
    var character: String? {
        return person.character?.capitalized
    }
    
    var profilePictureURL: URL? {
        return ImageManager.castImageUrl(with: person.profilePicturePath)
    }
}

struct Movie {
    let identifier:Int
    let title:String
    let overview:String
    let releaseDate:Date
    let originalTitle:String?
    let posterUrl:String?
    let backdropUrl:String?
    let avgRating:Double?
    var runTime:Int?
    
    let genreIds:[Int]
    
    var cast:[CastPerson] = []
    var director:CastPerson?
    
    init(identifier:Int, title: String, overview: String, date: Date, originalTitle: String?, posterUrl: String?, backdropUrl:String?, genreIds:[Int], avgRating: Double?, runtime:Int?) {
        self.identifier = identifier
        self.title = title
        self.overview = overview
        self.originalTitle = originalTitle
        self.posterUrl = posterUrl
        self.backdropUrl = backdropUrl
        self.releaseDate = date
        self.genreIds = genreIds
        self.avgRating = avgRating
        self.runTime = runtime
    }
    
    mutating func updateWith(jsonObject: JSONObject) {
        let runtime = jsonObject[Constants.ResponseParams.runtime] as? Int
        self.runTime = runtime
        
        guard let credits = jsonObject[Constants.ResponseParams.credits] as? JSONObject,
            let castList = credits[Constants.ResponseParams.cast] as? [JSONObject] else {
                return
        }
        
        if let crew = credits[Constants.ResponseParams.crew] as? [JSONObject] {
            if let director = crew.first(where: { $0["job"] as! String == "Director"}) {
                self.director = CastPerson(jsonObject: director)
            }
        }
        
        var cast:[CastPerson] = []
        for obj in castList {
            if let person = CastPerson(jsonObject: obj){
                cast.append(person)
            }
        }
        self.cast = cast
        
    }        
    
    static func fromJson(jsonObject: JSONObject) -> Movie? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = Constants.API.dateFormat
        
        guard let identifier = jsonObject[Constants.ResponseParams.id] as? Int,
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
        let avgRating = jsonObject[Constants.ResponseParams.avgRating] as? Double
        let runtime = jsonObject[Constants.ResponseParams.runtime] as? Int
        
        let movie = Movie(identifier: identifier, title: title, overview:overview, date: date, originalTitle: originalTitle, posterUrl: posterUrl, backdropUrl: backdropImageUrl, genreIds:genreIds, avgRating: avgRating, runtime:runtime)
        
        return movie
    }
}

