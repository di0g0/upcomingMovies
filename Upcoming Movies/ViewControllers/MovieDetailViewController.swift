//
//  MovieDetailViewController.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 30/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    var movie: MovieViewModel?
    
    @IBOutlet weak var backdropImage: UIImageView! {
        didSet {
            backdropImage.kf.indicatorType = .activity
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    
    func fillData(with movie:MovieViewModel) {
        self.title = movie.title
        self.releaseDateLabel.text = movie.releaseDateString
        self.overviewLabel.text = movie.overview
        self.genreLabel.text = movie.genreListString
        self.originalTitleLabel.text = movie.originalTitle
        if let backdropUrl = movie.backdropUrl {
            let placeholder:UIImage = .backdropPlaceholder
            self.backdropImage.kf.setImage(with: backdropUrl, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        if let movie = self.movie {
            self.fillData(with: movie)
        }
    }
}
