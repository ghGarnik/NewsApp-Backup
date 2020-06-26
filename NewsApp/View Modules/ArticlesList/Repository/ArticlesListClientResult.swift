//
//  ArticlesListClientResult.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum ArticlesListClientResult<Value> {
    case success(Value)
    case failure(ArticlesListClientError)
}

public typealias ArticlesClientResponse<Value> = (ArticlesListClientResult<Value>) -> ()
