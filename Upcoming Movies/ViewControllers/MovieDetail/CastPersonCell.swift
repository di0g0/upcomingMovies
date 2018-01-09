//
//  CastPersonCell.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 07/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//
import UIKit
class CastPersonCell: MovieTableViewCell {
    @IBOutlet weak var profilePicture: UIImageView! {
        didSet {
            profilePicture.layer.cornerRadius = 4
            profilePicture.clipsToBounds = true
            profilePicture.kf.indicatorType = .activity
        }
    }
    
    @IBOutlet weak var character: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func fill(with person: CastPersonViewModel) {
        self.name.text = person.name
        self.character.text = person.character
        if let pictureUrl = person.profilePictureURL {
            let placeholder:UIImage = .posterPlaceholder
            self.profilePicture.kf.setImage(with: pictureUrl, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
