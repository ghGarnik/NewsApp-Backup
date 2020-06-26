//
//  ArticleDetail.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public struct ArticleDetail: Codable {
    
    let content: String
    let date: String
    let id: Int
    let imageUrl: String
    let summary: String
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case content = "content"
        case date = "date"
        case id = "id"
        case imageUrl = "image_url"
        case summary = "summary"
        case title = "title"
    }
}
