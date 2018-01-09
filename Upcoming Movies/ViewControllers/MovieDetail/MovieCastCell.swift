//
//  MovieCastCell.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 07/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import UIKit

class MovieCastCell: MovieTableViewCell,MovieTableViewCellProtocol {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.allowsSelection = false
            collectionView.allowsMultipleSelection = false
            collectionView.isUserInteractionEnabled = false
        }
    }
    
    var cast:[CastPersonViewModel] = []
    
    override func fill(with movie: MovieViewModel) {
        self.cast = movie.cast
        self.collectionView.reloadData()
    }
}

extension MovieCastCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionCell.identifier, for: indexPath) as! CastCollectionCell
        let person = self.cast[indexPath.row]
        cell.castProfilePicturePath = person.profilePictureURL
        return cell
    }
}
