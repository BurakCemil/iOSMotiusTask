//
//  AccountPopupViewController.swift
//  GitHub Feedly
//
//  Created by Burak C on 28/12/2017.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

class AccountPopupViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var stackView: UIStackView!

    //MARK: Stored Properties
    let accounts: [Account] = DataHandler.accounts
    var delegate: AccountPopupViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 16

        addButtons()
    }

    //MARK: Functions
    private func addButtons() {
        for account in accounts {
            let button = UIButton(type: .roundedRect)
            button.setTitle(account.name, for: .normal)
            button.layer.cornerRadius = 15
            button.addTarget(self, action: #selector(AccountPopupViewController.changeAccount(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }

    //MARK: Button Actions
    @objc private func changeAccount(sender: UIButton!) {
        guard let accountName = sender.titleLabel?.text else {
            print("Account name not assigned to button")
            return
        }
        delegate?.didSelect(account: DataHandler.account(withId: accountName))
        dismiss(animated: true)
    }

    // Hide Pop-up when user touches outside of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
}

//MARK: Protocols

protocol AccountPopupViewControllerDelegate {
    func didSelect(account: Account?)
}
