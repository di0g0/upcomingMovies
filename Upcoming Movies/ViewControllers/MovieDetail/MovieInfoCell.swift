//
//  MovieInfoCell.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 07/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import UIKit
class MovieInfoCell: MovieTableViewCell,MovieTableViewCellProtocol {
    static let estimatedHeight:CGFloat = 59.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func fill(with movie: MovieViewModel, sectionType: MovieDetailSection) {
        switch sectionType {
        case .genres:
            self.titleLabel.text = LocationManager.genre
            self.detailLabel.text = movie.genreListString
        case .originalTitle:
            self.titleLabel.text = LocationManager.originalTitle
            self.detailLabel.text = movie.originalTitle
        case .releaseDate:
            self.titleLabel.text = LocationManager.releaseDate
            self.detailLabel.text = movie.releaseDateString
        case .overview:
            self.titleLabel.text = LocationManager.overview
            self.detailLabel.text = movie.overview
        case .director:
            self.titleLabel.text = LocationManager.director
            self.detailLabel.text = movie.directorName
        default:
            break
        }
    }
}
