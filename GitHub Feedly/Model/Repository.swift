//
//  Repository.swift
//  GitHub Feedly
//
//  Created by Burak C on 23/12/2017.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import Foundation

class Repository {
    //MARK: Stored Properties
    let name: String
    var commits: [Commit]

    //MARK: Initializers
    init(name: String) {
        self.name = name
        self.commits = []
    }

    //MARK: Functions
    public func addCommit(commit: Commit) {
        commits.append(commit)
    }
}

//MARK: Structs
struct Commit {
    let sha: String
    let author: String
    let message: String
}

//MARK: Extensions
extension Repository: CustomStringConvertible {
    var description: String {
        return "\(name)"
    }
}
