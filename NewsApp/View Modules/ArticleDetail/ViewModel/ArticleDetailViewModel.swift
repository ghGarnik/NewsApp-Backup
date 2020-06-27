//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public final class ArticleDetailViewModel {
    
    private let dependencies: ArticleDetailViewModelDependenciesProtocol
    private let router: ArticleDetailRouterProtocol
    private let articleId: Int
    
    public var articleDetail: Observable<ArticleDetail?> = Observable(nil)
    
    init(dependencies: ArticleDetailViewModelDependenciesProtocol,
         router: ArticleDetailRouterProtocol,
         articleId: Int) {
        self.dependencies = dependencies
        self.router = router
        self.articleId = articleId
    }
}

//MARK: - Protocol

extension ArticleDetailViewModel: ArticleDetailViewModelProtocol {
    public func viewDidLoad() {
        dependencies.repository.article(forId: articleId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articleResponse):
                let article = ArticleDetail(response: articleResponse)
                self.articleDetail.value = article
            case .failure(let error):
                self.manageError(error)
            }
        }
    }
    
    public func didTapOnFavouriteButton(isFavourite: Bool) {
        guard let currentState = articleDetail.value?.isFavourite,
            currentState != isFavourite else {
                return
        }
        
        articleDetail.value?.isFavourite = isFavourite
        //TODO: Change on Favourites Repository
    }

}

//MARK: - Error Managing

extension ArticleDetailViewModel {
    
    
    /// Manages repository fetching error.
    /// - Parameter error: Repository error.
    private func manageError(_ error: ArticleDetailClientError) {
        switch error {
        case .appError:
            router.showMessage(CommonCopies.appError) { [weak self] in
                guard let self = self else { return }
                self.viewDidLoad()
            }
        case .notLoggedIn:
            router.showMessage(CommonCopies.sessionExpired) { [weak self]  in
                guard let self = self else { return }
                self.logout()
            }
        }
    }
    
    private func logout() {
        dependencies.sessionManager.removeCurrentToken(completion: { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success:
                self.router.logoutDidSucceed()
            case .error:
                self.router.showMessage(CommonCopies.appError) { [weak self] in
                    guard let self = self else { return }
                    self.logout()
                }
            }
        })
    }
}
