//
//  URLSession+URLSessionProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 28/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()

protocol URLSessionProtocol {
    
    func dataTask(with request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completion) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
}
