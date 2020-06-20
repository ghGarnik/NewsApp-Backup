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
    
    private enum ErrorCaptions: String {
        case invalidRequest = "Invalid Request"
        case invalidResponse = "Invalid Server Response"
    }
    
    private var session: URLSession
    private var activeRequest: URLSessionDataTask?
    
    init() {
        session = URLSession.shared
    }
    
    func execute<T: APIRequest>(_ request: T,
                                parameters: Parameters = nil,
                                completion: @escaping Response<T.Response>) {
        activeRequest?.cancel()
        guard let urlRequest = configureUrlRequest(request, parameters: parameters) else {
            completion(.failure(.networking(ErrorCaptions.invalidRequest.rawValue)))
            return
        }
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                if let error = error,
                    let httpResponse = response as? HTTPURLResponse {
                    let errorToForward = self.errorType(for: error, statusCode: httpResponse.statusCode)
                    completion(.failure(errorToForward))
                } else {
                    completion(.failure(.unknownError))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.successful(response))
            } catch {
                completion(.failure(.networking(ErrorCaptions.invalidResponse.rawValue)))
            }
        })
        task.resume()
        activeRequest = task
    }
    
    private func configureUrlRequest<T: APIRequest>(_ request: T,
                                             parameters: Parameters?) -> URLRequest? {
        guard let url = URL(string: request.path) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        Constants.defaultHeaders?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let parameters = parameters,
            let body = try? JSONSerialization.data(withJSONObject: parameters as Any, options: []) {
            urlRequest.httpBody = body
        }
        return urlRequest
    }
    
    private func errorType(for error: Error, statusCode: Int) -> NewsError {
        if HTTPStatus.forbidden.contains(statusCode) {
            return .forbidden
        }
        
        if HTTPStatus.serverError.contains(statusCode) {
            return .server(error: error)
        }
        
        return .unknownError
    }
    
}
