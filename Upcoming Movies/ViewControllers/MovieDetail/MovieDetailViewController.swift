//
//  MovieDetailViewController.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 30/12/2017.
//  Copyright © 2017  Diogo Costa. All rights reserved.
//

import UIKit
import Kingfisher
import ParallaxHeader

enum MovieDetailSection {
    case header
    case releaseDate
    case genres
    case cast
    case originalTitle
    case director
    case overview
}

struct SectionObject {
    let sectionRows:[MovieDetailSection]
    let sectionTitle:String
}

class MovieDetailHeaderView: UIView, MovieTableViewCellProtocol {
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.cornerRadius = 6
            posterImageView.clipsToBounds = true
            posterImageView.kf.indicatorType = .activity
        }
    }
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.blurView.setup(style: UIBlurEffectStyle.dark, alpha: 0).enable()
        }
    }
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var avgRatingLagel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func fill(with movie: MovieViewModel) {
        self.movieTitleLabel.text = movie.title
        if let pictureUrl = movie.pictureUrl {
            let placeholder:UIImage = .posterPlaceholder
            self.posterImageView.kf.setImage(with: pictureUrl, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        }
        if let backdropUrl = movie.backdropUrl {
            let placeholder:UIImage = .backdropPlaceholder
            self.backgroundImageView.kf.setImage(with: backdropUrl, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        }
        self.avgRatingLagel.text = movie.avgRatingString
        self.yearLabel.text = movie.yearString
        self.timeLabel.text = movie.timeString
    }
    
}

class MovieDetailViewController: UIViewController {
    var movie: MovieViewModel?
    
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var headerView: MovieDetailHeaderView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = MovieInfoCell.estimatedHeight
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    
    
    
    @IBOutlet weak var backdropImage: UIImageView! {
        didSet {
            backdropImage.kf.indicatorType = .activity
        }
    }
    
    let sections:[SectionObject] = [
        SectionObject(sectionRows: [.genres,.overview], sectionTitle: ""),
        SectionObject(sectionRows: [.releaseDate, .originalTitle,.director], sectionTitle: LocationManager.details),
        SectionObject(sectionRows: [.cast], sectionTitle: LocationManager.cast),
    ]
    
    func fillData(with movie:MovieViewModel) {
        self.headerView.fill(with: movie)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if segue.identifier == "openCastSegue",
            let castViewController = segue.destination as? CastViewController,
            let movie = self.movie
        {
            castViewController.cast = movie.cast
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let navController = self.navigationController {
            UIView.animate(withDuration: 0.3, animations: {
                navController.navigationBar.titleTextAttributes =
                    [NSAttributedStringKey.foregroundColor: UIColor.movieOrange]
                navController.navigationBar.tintColor = UIColor.movieOrange
                navController.navigationBar.setBackgroundImage(nil, for: .default)
                navController.navigationBar.shadowImage = nil
            })
        }
    }
    
    fileprivate func setupHeaderView() {
        tableView.parallaxHeader.view = self.headerView.backgroundImageView
        tableView.parallaxHeader.height = self.headerView.backgroundImageView.frame.height
        tableView.parallaxHeader.minimumHeight = (self.navigationController?.navigationBar.frame.maxY)!
        tableView.parallaxHeader.mode = .centerFill
        tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { [weak self] parallaxHeader in
            guard let strongSelf = self else {
                return
            }
            let alpha = 1 - parallaxHeader.progress
            parallaxHeader.view.blurView.alpha = alpha < 0.4 ? 0.4 : alpha
            if alpha >= 1{
                strongSelf.title = strongSelf.movie?.title
                strongSelf.tableView.sendSubview(toBack: strongSelf.headerView)
            } else {
                strongSelf.title = ""
                strongSelf.tableView.bringSubview(toFront: strongSelf.headerView)
            }
        }
        self.headerView.clipsToBounds = false
        self.headerView.frame.size.height = self.headerView.frame.size.height - self.headerView.backgroundImageView.frame.height
        self.tableView.bringSubview(toFront: self.headerView)
        tableView.parallaxHeader.view.blurView.alpha = 0.4
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationItem.title = ""
        self.navigationItem.largeTitleDisplayMode = .never
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupHeaderView()
        if let movie = self.movie {
            self.fillData(with: movie)
            movie.onMovieUpdated = {
                self.fillData(with: movie)
            }
            movie.getDetails()
        }
    }
}

extension MovieDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = self.movie else {return UITableViewCell()}
        let section = self.sections[indexPath.section]
        let row = section.sectionRows[indexPath.row]
        switch row {
        case .cast:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCastCell.identifier, for: indexPath) as?
                MovieCastCell else {return UITableViewCell()}
            cell.fill(with: movie)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.identifier, for: indexPath) as?
                MovieInfoCell else {return UITableViewCell()}
            cell.fill(with: movie, sectionType: row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        return section.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.sectionRows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
}


