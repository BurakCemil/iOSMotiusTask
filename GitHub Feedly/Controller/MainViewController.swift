//
//  ViewController.swift
//  GitHub Feedly
//
//  Created by Burak C on 23/12/2017.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var repoTableView: UITableView!
    
    //MARK: Stored Properties
    var currentAccount: Account? = nil

    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch repo for all accounts and reload the tableView when data is recieved.
        DataHandler.loadAllRepos { () -> () in
            self.repoTableView.reloadData()
        }
        currentAccount = DataHandler.accounts.first
        accountLabel.text = currentAccount?.name
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let detailViewController as RepoDetailViewController:
            guard let senderCell = sender as? UITableViewCell, let repository = currentAccount?.repositories[senderCell.tag] else {
                print("Unknown sender to RepoDetailViewController")
                return
            }
            detailViewController.currentRepository = repository
        case let accountSelectionController as AccountPopupViewController:
            accountSelectionController.delegate = self
        default:
            print("Unknown Destination")
        }
    }
}

//MARK: Extensions
extension MainViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowCount = currentAccount?.repositories.count else {
            print("tableView returned 0 elements")
            return 0
        }
        return rowCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        cell.tag = indexPath.row
        cell.textLabel?.text = currentAccount?.repositories[indexPath.row].name
        cell.detailTextLabel?.text = " "
        return cell
    }
}

extension MainViewController: AccountPopupViewControllerDelegate {
    func didSelect(account: Account?) {
        currentAccount = account
        accountLabel.text = currentAccount?.name
        repoTableView.reloadData()
    }

}
