//
//  Account.swift
//  GitHub Feedly
//
//  Created by Burak C on 23/12/2017.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import Foundation

class Account {

    // MARK: Stored Properties
    var name: String
    var repositories: [Repository]

    init(name: String) {
        self.name = name
        self.repositories = []
    }

    //MARK: Functions
    func addRepository(repository: Repository) {
        repositories.append(repository)
    }
}

//MARK: Extensions
extension Account: CustomStringConvertible {
    var description: String {
        return "Account name: \(name)\n repositories: \(repositories)"
    }
}
