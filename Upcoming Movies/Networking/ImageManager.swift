//
//  ImageManager.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 03/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import Foundation

class ImageManager {
    private static var baseImageUrl:String?
    private static let posterCellWidth:String = "w185"
    private static let detailBackdropWidth:String = "w1280"
    
    class func updateImageConfig() {
        APIClient.getConfig(completion: { (imageBaseUrl,success) in
            guard let baseUrl = imageBaseUrl, success else {
                return
            }
            baseImageUrl = baseUrl
        })
    }
    
    private class func imageUrl(with imagePath:String?, widthParam:String) -> URL? {
        if let baseUrl = ImageManager.baseImageUrl, let path = imagePath {
            return URL(string: baseUrl + widthParam + path)
        }
        return nil
    }
    
    class func backdropImageUrl(with imagePath: String?) -> URL? {
        return imageUrl(with: imagePath, widthParam: ImageManager.detailBackdropWidth)
    }
    
    class func posterImageUrl(with imagePath: String?) -> URL? {
        return imageUrl(with: imagePath, widthParam: ImageManager.posterCellWidth)
    }
}


