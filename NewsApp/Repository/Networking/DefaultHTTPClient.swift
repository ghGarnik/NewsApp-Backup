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
        static let bearer = "Bearer"
        static let authorization = "Authorization"
    }
    
    private enum ErrorCaptions: String {
        case invalidRequest = "Invalid Request"
        case invalidResponse = "Invalid Server Response"
    }
    
    private let dependencies: DefaultHTTPClientDependenciesProtocol
    private var session: URLSession
    private var activeRequest: URLSessionDataTask?
    
    init(dependencies: DefaultHTTPClientDependenciesProtocol) {
        self.dependencies = dependencies
        session = URLSession.shared
    }
    
    //MARK: -  Execute Request
    
    /// Makes a HTTP Request.
    /// - Parameter request: Request to make
    /// - Parameter parameters: Parameters to include in the body.
    /// - Parameter completion: Closure to execute.
    public func execute<T: APIRequest>(_ request: T,
                                parameters: Parameters = nil,
                                completion: @escaping NetworkResponse<T.Response>) {
        if request.auth {
            dependencies.sessionManager.retrieveSessionToken { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    self.doRequest(request,
                                   parameters: parameters,
                                   token: token,
                                   completion: completion)
                case .failure:
                    completion(.failure(.forbidden))
                }
            }
        } else {
            self.doRequest(request,
                           parameters: parameters,
                           completion: completion)
        }
    }
    
    //MARK: - Private methods.
    
    
    /// Makes HTTPRequest based on argument parameters.
    /// - Parameter request: APIRequest object.
    /// - Parameter parameters: Parameters to include in the body.
    /// - Parameter token: JWT for requests that require to be authenticated.
    /// - Parameter completion: Closure that manages result of the request.
    private func doRequest<T: APIRequest>(_ request: T,
                                          parameters: Parameters = nil,
                                          token: String? = nil,
                                          completion: @escaping NetworkResponse<T.Response>) {
        //Cancels previous request if exists. Just to avoid side effects.
        activeRequest?.cancel()
        
        //Creates URLRequest object based on request parameters.
        guard let urlRequest = configureUrlRequest(request,
                                                   parameters: parameters,
                                                   token: token) else {
            completion(.failure(.networking(ErrorCaptions.invalidRequest.rawValue)))
            return
        }
        
        let task = session.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
            
            //Error Management
            
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
            
            //Response decode
            
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
    
    /// Returns a URLRequest based on request parameters.
    /// - Parameter request: APIRequest object.
    /// - Parameter parameters: Parameters to include in HTTPBody.
    private func configureUrlRequest<T: APIRequest>(_ request: T,
                                                    parameters: Parameters = nil,
                                                    token: String?) -> URLRequest? {
        guard let url = URL(string: request.path) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        Constants.defaultHeaders?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        if let token = token {
            urlRequest.setValue("\(Constants.bearer) \(token)", forHTTPHeaderField: Constants.authorization)
        }
        
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
