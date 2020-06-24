//
//  DefaultHTTPClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public final class DefaultHTTPClient: HTTPClient {
    
    //MARK: - Initial setup
    
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
    
    //MARK: -  Execute Request
    
    /// Makes a HTTP Request.
    /// - Parameter request: Request to make
    /// - Parameter parameters: Parameters to include in the body.
    /// - Parameter completion: Closure to execute.
    func execute<T: APIRequest>(_ request: T,
                                parameters: Parameters = nil,
                                completion: @escaping NetworkResponse<T.Response>) {
        
        //Cancels previous request if exists. Just to avoid side effects.
        activeRequest?.cancel()
        
        guard let urlRequest = configureUrlRequest(request, parameters: parameters) else {
            completion(.failure(.networking(ErrorCaptions.invalidRequest.rawValue)))
            return
        }
        
        let task = session.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }
            
            if let statusError = self.statusErrorType(httpResponse.statusCode) {
                completion(.failure(statusError))
                return
            }
            
            guard let data = data else {
                if let _ = error {
                    completion(.failure(.server))
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
    
    //MARK: - Private methods.
    
    /// Returns a URLRequest based on request parameters.
    /// - Parameter request: APIRequest object.
    /// - Parameter parameters: Parameters to include in HTTPBody.
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
    
    /// Returns an error if the response status code contains any error code.
    /// - Parameter statusCode: A HTTP response status code.
    private func statusErrorType(_ statusCode: Int) -> NetworkingError? {
        if HTTPStatus.forbidden.contains(statusCode) {
            return .forbidden
        }
        
        if HTTPStatus.serverError.contains(statusCode) {
            return .server
        }
        
        return nil
    }
}
