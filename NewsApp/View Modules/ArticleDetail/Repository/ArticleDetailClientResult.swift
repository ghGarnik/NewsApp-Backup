//
//  ArticleDetailClientResult.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum ArticleDetailClientResult<Value> {
    case success(Value)
    case failure(ArticleDetailClientError)
}

public typealias ArticleDetailClientResponse<Value> = (ArticleDetailClientResult<Value>) -> ()
