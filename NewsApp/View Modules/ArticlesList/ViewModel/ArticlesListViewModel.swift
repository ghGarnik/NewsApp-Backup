//
//  ArticlesListViewModel.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

//MARK: - Implementation

public class ArticlesListViewModel {
    
    private let dependencies: ArticlesListViewModelDependenciesProtocol
    private let router: ArticlesListRouterProtocol
    
    var articles: Observable<[CompactArticle]> = Observable([])
    
    public init(dependencies: ArticlesListViewModelDependenciesProtocol, router: ArticlesListRouterProtocol) {
        self.dependencies = dependencies
        self.router = router
    }
}

//MARK: - Protocol

extension ArticlesListViewModel: ArticlesListViewModelProtocol {
    func viewDidLoad() {
        dependencies.articlesRepository.retrieveArticles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                let articlesObservable = Observable(articles)
                self.articles.value = articles
            case .failure(let error):
                switch error {
                case .notLoggedIn:
                    self.router.showMessage(CommonCopies.sessionExpired) { [weak self] in
                        guard let self = self else { return }
                        self.didTapOnLogout()
                    }
                case .appError:
                    self.router.showMessage(CommonCopies.appError) { [weak self] in
                        guard let self = self else { return }
                        self.viewDidLoad()
                    }
                }
            }
        }
    }
    
    func didTapOnArticle(_ article: Int) {
        router.navigateToArticle(article)
    }
    
    func didTapOnLogout() {
        dependencies.sessionManager.removeCurrentToken(completion: { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success:
                self.router.logoutDidSucceed()
            case .error:
                self.router.showMessage(CommonCopies.appError) { [weak self] in
                    guard let self = self else { return }
                    self.didTapOnLogout()
                }
            }
        })
    }
}
