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
    
    @IBOutlet private weak var articlesListTable: UITableView!
    
    private enum Constants {
        static let rowHeight: CGFloat = 160
    }
    
    private var articles: [CompactArticle] = [] {
        didSet {
            DispatchQueue.main.async { [weak self]  in
                guard let self = self else { return }
                self.articlesListTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupNavigationBar()
        setupArticlesListTable()
        viewModel?.viewDidLoad()
    }
    
    private func setupBindings() {
        viewModel?.articles.bind({ [weak self] articles in
            guard let self = self else { return }
            self.articles = articles
        })
    }
    
    private func setupNavigationBar() {
        self.title = ArticlesListCopies.listTitle

        let logoutButton = UIBarButtonItem(title: ArticlesListCopies.logout, style: .plain, target: self, action: #selector(logout))
        navigationItem.setRightBarButton(logoutButton, animated: false)
    }
    
    
    
    @objc private func logout() {
        viewModel?.didTapOnLogout()
    }
}

//MARK: - TableView Setup

extension ArticlesListViewController {
    
    private func setupArticlesListTable() {
        articlesListTable.dataSource = self
        articlesListTable.delegate = self
        
        articlesListTable.allowsMultipleSelection = false
        articlesListTable.separatorStyle = .none
       
        articlesListTable.register(cellType: ArticleCell.self)
    }
}

extension ArticlesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleCell: ArticleCell = tableView.dequeueCell(forIndexPath: indexPath),
            articles.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }
        let article = articles[indexPath.row]
        articleCell.configureCell(article)
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}

extension ArticlesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard articles.indices.contains(indexPath.row) else {
                return
        }
        
        let article = articles[indexPath.row]
        viewModel?.didTapOnArticle(article.id)
    }
}
