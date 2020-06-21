//
//  LoginClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public typealias Path = String
public typealias Parameters = [String: Any]?
public typealias Headers = [String: String]?

//MARK: - Dependencies

protocol LoginClientDependenciesProtocol {
    var networkManager: HTTPClient { get }
}

final class LoginClientDependencies: LoginClientDependenciesProtocol {
    lazy var networkManager: HTTPClient = DefaultHTTPClient()
}

//MARK: - Protocol

protocol LoginClient {
    func login(_ loginSettings: LoginCredentials, completion: @escaping LoginClientResponse)
}

//MARK: - Default Implementation

class DefaultLoginClient: LoginClient {
    private let dependencies: LoginClientDependenciesProtocol
    
    init(dependencies: LoginClientDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    
    /// Logs in with user credentials.
    /// - Parameter loginCredentials: user credentials.
    /// - Parameter completion: LoginCLientResponse that will handle success and error.
    func login(_ loginCredentials: LoginCredentials, completion: @escaping LoginClientResponse) {
        let url = Endpoints.login.url
        let request = LoginRequest(path: url)
        
        dependencies.networkManager.execute(request,
                               parameters: loginCredentials.toParammeters(),
                               completion: { response in
                                switch response {
                                case .successful(let fetchedData):
                                    self.loginDidSucceed(with: fetchedData?.accessToken ?? "")
                                    completion(.successful)
                                case .failure(let error):
                                    completion(.failure(error))
                                }
        })
    }
    
    private func loginDidSucceed(with token: String) {
        print("login successful: \n accessToken \(token)")
    }
}
