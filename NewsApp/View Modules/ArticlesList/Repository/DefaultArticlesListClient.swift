//
//  DefaultArticlesListClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public class DefaultArticlesListClient {
    
    private let dependencies: DefaultArticlesListClientDependenciesProtocol
    
    public init(dependencies: DefaultArticlesListClientDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension DefaultArticlesListClient: ArticlesListClient {
    public func retrieveArticles(completion: @escaping ArticlesClientResponse<ArticlesListResponse>) {
        let request = ArticlesListRequest(path: Endpoints.articlesList.url)
        dependencies.network.execute(request,
                                     parameters: nil) { response in
                                        switch response {
                                        case .successful(let articles):
                                            guard let articles = articles else {
                                                completion(.failure(.appError))
                                                return
                                            }
                                            completion(.success(articles))
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
