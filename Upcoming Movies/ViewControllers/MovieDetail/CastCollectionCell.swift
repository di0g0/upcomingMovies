//
//  CastCollectionCell.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 07/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//
import UIKit
class CastCollectionCell: UICollectionViewCell {
    static let identifier = "CastCollectionCell"
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = false
    }
    
    @IBOutlet weak var profilePicture: UIImageView! {
        didSet {
            profilePicture.clipsToBounds = true
            profilePicture.layer.cornerRadius = 4
            profilePicture.kf.indicatorType = .activity
        }
    }
    
    override func prepareForReuse() {     
        profilePicture.image = nil
    }
    
    var castProfilePicturePath:URL? {
        didSet {
            if let url = castProfilePicturePath {
                let placeholder:UIImage = .backdropPlaceholder
                profilePicture.kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
}
