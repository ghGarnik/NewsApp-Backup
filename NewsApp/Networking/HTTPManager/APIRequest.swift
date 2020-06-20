//
//  APIRequest.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol APIRequest: Encodable {
    
    associatedtype Response: Decodable
    
    var method: HTTPMethods { get }
    var headers: Headers { get }
    var encoding: HTTPEncoding { get }
    var path: Path { get }
}
