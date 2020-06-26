//
//  ArticleDetailRequest.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

final class ArticleDetailRequest: APIRequest {
    
    typealias Response = ArticleDetail?
    
    let path: Path
    var method: HTTPMethods { return .get }
    var headers: Headers { return nil }
    var encoding: HTTPEncoding { return .jsonEncoding }
    var auth: Bool { return true }
    
    init(path: Path) {
        self.path = path
    }
}

