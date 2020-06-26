//
//  HTTPClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol HTTPClient: class {
    func execute<T: APIRequest>(_ request: T,
                                parameters: Parameters,
                                completion: @escaping NetworkResponse<T.Response>)
}
