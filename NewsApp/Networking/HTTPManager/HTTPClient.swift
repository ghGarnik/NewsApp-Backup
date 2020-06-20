//
//  HTTPClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol HTTPClient: class {
    func execute<T: APIRequest>(_ request: T,
                                parameters: Parameters,
                                completion: @escaping Response<T.Response>)
}


final class DefaultHTTPClient: HTTPClient {
    
    private enum Constants {
        static let defaultHeaders: Headers = ["accept": "application/json",
                                              "Content-Type": "application/json"]
    }
    
    private var session: URLSession
    //private var activeRequest: Request?
    //private let currentQueue: OperationQueue
    
    init() {
        session = URLSession.shared
    }
    
    func execute<T: APIRequest>(_ request: T,
                                parameters: Parameters = nil,
                                completion: @escaping Response<T.Response>) {
        guard let url = URL(string: request.path) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        Constants.defaultHeaders?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    
        if let parameters = parameters,
            let body = try? JSONSerialization.data(withJSONObject: parameters, options: []){
            urlRequest.httpBody = body
        }
        
        
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                
                if let response = response {
                    print(response)
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.successful(response))
            } catch (let error) {
                completion(.failure(error))
            }
            })
            .resume()
    }
    
}
