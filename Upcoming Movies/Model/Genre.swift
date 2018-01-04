//
//  Genre.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 01/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

struct Genre {
    let identifier:Int
    let name:String
    
    init(id:Int, name:String) {
        self.identifier = id
        self.name = name
    }
    
    static func fromJson(jsonObject: [String: Any]) -> Genre? {
        guard let id = jsonObject[Constants.ResponseParams.id] as? Int,
            let name = jsonObject[Constants.ResponseParams.name] as? String else {
                return nil
        }
        
        return Genre(id: id, name: name)
    }
}
