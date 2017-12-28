//
//  DataHandler.swift
//  GitHub Feedly
//
//  Created by Burak C on 23/12/2017.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import Foundation
import Alamofire

class DataHandler {

    // MARK: Static Stored Properties
    static var accounts: [Account] = []
    static let apiUrl = "https://api.github.com"

    // MARK: Static Functions
    static func fetchRepos(of account: Account, completionHandler: @escaping () -> ()) {
        // URL String for API call
        let apiEndpoint = "\(apiUrl)/users/\(account.name)/repos"
        Alamofire.request(apiEndpoint).responseJSON { response in

            switch response.result {
            case .success:
                if let json = response.result.value as? [[String: Any]] {
                    for item in json {
                        if let name = item["name"] as? String {
                            print(name)
                            let repo = Repository(name: name)
                            fetchCommits(of: repo, account: account)
                            account.addRepository(repository: repo)
                        }
                    }
                }
                print("Executing completion handler")
                completionHandler()
            case .failure(let error):
                print("Request to fetch user repositories failed: \(error)")
            }
        }
    }

    static func fetchCommits(of repository: Repository, account: Account){
        // URL String for API call
        let apiEndpoint = "\(apiUrl)/repos/\(account.name)/\(repository.name)/commits"
        Alamofire.request(apiEndpoint).responseJSON { response in

            switch response.result {
            case .success:
                if let json = response.result.value as? [[String: Any]] {
                    // Parse first 10 items in the response JSON which includes commits sorted by date
                    let jsonToParse = (json.count > 10 ? json[0...9] : json[0...])
                    for item in jsonToParse {
                        if let sha = item["sha"] as? String, let commit = item["commit"] as? [String: Any],
                            let author = commit["author"] as? [String: Any], let authorName = author["name"] as? String, let message = commit["message"] as? String {
                            let newCommit = Commit(sha: String(sha.prefix(6)), author: authorName, message: message)
                            repository.addCommit(commit: newCommit)
                            print("Added commit with sha: \(sha.prefix(6)))")
                        }
                    }
                }
            case .failure(let error):
                print("Request to fetch commits for the repository failed: \(error)")
            }
        }
    }
    
    static func loadAllRepos(completionHandler: @escaping () -> ()) {
        for account in DataHandler.accounts {
            DataHandler.fetchRepos(of: account, completionHandler: completionHandler)
        }
        print("Executing completion handler")
    }

    static func account(withId name: String) -> Account? {
        return accounts.filter({ $0.name == name }).first
    }
}
