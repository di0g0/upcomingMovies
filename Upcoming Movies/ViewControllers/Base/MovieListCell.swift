//
//  MovieListCell.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 29/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListCell: MovieTableViewCell,MovieTableViewCellProtocol {
    static let movieCellHeight:CGFloat = 150.0
    
    @IBOutlet weak var avgRatingLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGendersLabel: UILabel!
    @IBOutlet weak var movieImagePicture: UIImageView! {
        didSet {
            movieImagePicture.layer.cornerRadius = .movieCornerRadius
            movieImagePicture.clipsToBounds = true
            movieImagePicture.kf.indicatorType = .activity            
        }
    }
    
    override func prepareForReuse() {
        movieImagePicture.image = nil
    }
    
    override func fill(with movie: MovieViewModel) {
        self.movieNameLabel.text = movie.title
        if let pictureUrl = movie.pictureUrl {
            let placeholder:UIImage = .posterPlaceholder    
            self.movieImagePicture.kf.setImage(with: pictureUrl, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        }
        self.movieGendersLabel.text = movie.genreListString
        self.avgRatingLabel.text = movie.avgRatingString
    }
}

