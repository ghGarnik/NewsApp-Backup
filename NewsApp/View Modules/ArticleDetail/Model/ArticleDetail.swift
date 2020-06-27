//
//  ArticleDetail.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

struct ArticleDetail {

    let content: String
    let id: Int
    let imageUrl: String
    let summary: String
    let title: String
    let author: String
    var isFavourite: Bool = false

    init(response: ArticleDetailResponse) {
        content = response.content
        id = response.id
        imageUrl = response.imageUrl
        summary = response.summary
        title = response.title

        let date = response.date.replacingOccurrences(of: "-", with: "/")
        author = ArticleDetailCopies.author.appending(" - \(date)")
    }
}
