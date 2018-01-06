//
//  GenreViewModel.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 03/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

class GenreManager {
    static var genreList:[Genre] = []
    
    class func updateGenreList() {
        ConfigServices.getGenreList { (response) in
            switch response {
            case let .Failure(error):
                print(error)
            case let .Success(genreResponse):
                genreList.removeAll()
                for item in genreResponse.genreList {
                    if let genre = Genre.fromJson(jsonObject: item) {
                        genreList.append(genre)
                    }
                }
            }
        }        
    }
}
