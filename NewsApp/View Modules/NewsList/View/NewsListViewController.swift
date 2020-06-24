//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController, AlertShowing {

    var viewModel: NewsListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogoutButton()
    }
    
    private func setLogoutButton() {
        let logoutButton = UIBarButtonItem(title: NewsListCopies.logout, style: .plain, target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: false)
    }
    
    @objc private func logout() {
        viewModel?.didTapOnLogout()
    }
}
