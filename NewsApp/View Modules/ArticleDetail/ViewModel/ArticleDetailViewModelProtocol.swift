//
//  ArticleDetailViewModelProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol ArticleDetailViewModelProtocol {
    var articleDetail: Observable<ArticleDetail?> { get set }
    func viewDidLoad()
    func didTapOnFavouriteButton(isFavourite: Bool)
}
