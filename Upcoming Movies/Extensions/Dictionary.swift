//
//  Dictionary.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 06/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

extension Dictionary {
    mutating func append(dictionary: Dictionary?) {
        guard let dictionary = dictionary else {return}
        for (key, value)  in dictionary {
            self.updateValue(value, forKey: key)
        }
    }
}
