//
//  MovieListCell.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 29/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListCell: UITableViewCell {
    static let identifier = "MovieListCell"
    static let movieCellHeight:CGFloat = 150.0
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGendersLabel: UILabel!
    @IBOutlet weak var movieImagePicture: UIImageView! {
        didSet {
            movieImagePicture.layer.cornerRadius = 6
            movieImagePicture.clipsToBounds = true
            movieImagePicture.kf.indicatorType = .activity
        }
    }
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func prepareForReuse() {
        movieImagePicture.image = nil
    }
    
    func fill(with movie: MovieViewModel) {
        self.movieNameLabel.text = movie.title
        if let pictureUrl = movie.pictureUrl {
            let placeholder:UIImage = .posterPlaceholder    
            self.movieImagePicture.kf.setImage(with: pictureUrl, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        }
        self.releaseDateLabel.text = movie.releaseDateString
        self.movieGendersLabel.text = movie.genreListString
    }
}

