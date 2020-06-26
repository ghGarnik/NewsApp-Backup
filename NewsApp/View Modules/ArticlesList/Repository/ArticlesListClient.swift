//
//  ArticlesListClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol ArticlesListClient {
    func retrieveArticles(completion: @escaping ArticlesClientResponse<[CompactArticle]>)
}
