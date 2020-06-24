//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol NewsListViewModelDependenciesProtocol {
    var sessionManager: SessionManagerProtocol { get }
}

public class NewsListViewModelDependencies: NewsListViewModelDependenciesProtocol {
    public lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}

public class NewsListViewModel {
    
    private let dependencies: NewsListViewModelDependenciesProtocol
    private let router: NewsListRouterProtocol
    
    public init(dependencies: NewsListViewModelDependenciesProtocol, router: NewsListRouterProtocol) {
        self.dependencies = dependencies
        self.router = router
    }
}

extension NewsListViewModel: NewsListViewModelProtocol {
    func didTapOnLogout() {
        dependencies.sessionManager.removeCurrentToken(completion: { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success:
                self.router.logoutDidSucceed()
            case .error:
                self.router.logoutDidFail(CommonCopies.appError)
            }
        })
    }
}
