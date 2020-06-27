//
//  CompactArticle.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

struct CompactArticle: Codable {

    let date: String
    let title: String
    let summary: String
    let id: Int
    let thumbnailURL: String

    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case title = "title"
        case summary = "summary"
        case id = "id"
        case thumbnailURL = "thumbnail_url"
    }
}
