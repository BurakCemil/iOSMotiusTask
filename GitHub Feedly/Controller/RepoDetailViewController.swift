//
//  RepoDetailViewController.swift
//  GitHub Feedly
//
//  Created by Burak C on 23/12/2017.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commitLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}

class RepoDetailViewController: UIViewController {

    @IBOutlet weak var commitTableView: UITableView!
    //MARK: Stored Properties
    var currentRepository: Repository? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        commitTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
}

//MARK: Extensions
extension RepoDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowCount = currentRepository?.commits.count else {
            return 0
        }
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commitTableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as! CommitTableViewCell

        cell.authorLabel?.text = currentRepository?.commits[indexPath.row].author
        cell.commitLabel?.text = currentRepository?.commits[indexPath.row].sha
        cell.messageLabel?.text = currentRepository?.commits[indexPath.row].message
        return cell
    }



}
