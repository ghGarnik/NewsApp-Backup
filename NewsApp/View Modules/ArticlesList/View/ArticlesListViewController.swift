//
//  ArticlesListViewController.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController, AlertShowing {

    var viewModel: ArticlesListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogoutButton()
        viewModel?.viewDidLoad()
    }
    
    private func setLogoutButton() {
        let logoutButton = UIBarButtonItem(title: ArticlesListCopies.logout, style: .plain, target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: false)
    }
    
    @objc private func logout() {
        viewModel?.didTapOnLogout()
    }
}
