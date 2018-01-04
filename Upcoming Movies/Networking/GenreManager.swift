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
        APIClient.getGenreList { (jsonList,success) in
            guard success, let list = jsonList else {return}
            genreList.removeAll()
            for item in list {
                if let genre = Genre.fromJson(jsonObject: item) {
                    genreList.append(genre)
                }
            }
        }        
    }
}
