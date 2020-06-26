//
//  ArticlesListViewModelProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol ArticlesListViewModelProtocol: class {
    var articles: Observable<[CompactArticle]> { get set }
    func viewDidLoad()
    func didTapOnArticle(_: Int)
    func didTapOnLogout()
}
