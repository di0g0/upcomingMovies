//
//  MovieTableViewCell.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 07/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//
import UIKit
protocol MovieTableViewCellProtocol {
    func fill(with movie: MovieViewModel)
}

class MovieTableViewCell: UITableViewCell {
    func fill(with movie: MovieViewModel) {}
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.selectedBackgroundView = bgView
    }
}

