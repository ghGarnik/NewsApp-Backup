//
//  ArticleDetailClientResult.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

enum ArticleDetailClientResult<Value> {
    case success(Value)
    case failure(ArticleDetailClientError)
}

typealias ArticleDetailClientResponse<Value> = (ArticleDetailClientResult<Value>) -> ()
