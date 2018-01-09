//
//  CastViewController.swift
//  Upcoming Movies
//
//  Created by  Diogo Costa on 07/01/2018.
//  Copyright © 2018  Diogo Costa. All rights reserved.
//

import UIKit
class CastViewController : UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var cast:[CastPersonViewModel] = []
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.rowHeight = 90
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.title = LocationManager.cast
        self.tableView.reloadData()
    }
}

extension CastViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = self.cast[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CastPersonCell.identifier, for: indexPath) as!
        CastPersonCell
        cell.fill(with: person)
        return cell
    }
}
