//
//  DefaultArticleDetailClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public class DefaultArticleDetailClient {
    
    private let dependencies: DefaultArticleDetailClientDependenciesProtocol
    
    public init(dependencies: DefaultArticleDetailClientDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension DefaultArticleDetailClient: ArticleDetailClient {
    public func article(forId id: Int, completion: @escaping ArticleDetailClientResponse<ArticleDetail>) {
        let path = Endpoints.articlesList.url.appending(("/\(id)"))
        let request = ArticleDetailRequest(path: path)
        dependencies.network.execute(request,
                                     parameters: nil) { result in
                                        switch result {
                                        case .successful(let article):
                                            guard let article = article else { return }
                                            completion(.success(article))
                                        case .failure(let error):
                                            switch error {
                                            case .forbidden:
                                                completion(.failure(.notLoggedIn))
                                            default:
                                                completion(.failure(.appError))
                                            }
                                        }
        }
    }
}
