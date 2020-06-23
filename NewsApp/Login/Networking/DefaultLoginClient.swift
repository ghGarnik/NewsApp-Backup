//
//  LoginClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

//MARK: - Dependencies

protocol LoginClientDependenciesProtocol {
    var networkManager: HTTPClient { get }
    var sessionManager: SessionManagerProtocol { get }
}

final class LoginClientDependencies: LoginClientDependenciesProtocol {
    lazy var networkManager: HTTPClient = DefaultHTTPClient()
    lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}

//MARK: - Protocol

protocol LoginClient {
    func login(_ loginSettings: LoginCredentials, completion: @escaping LoginClientResponse)
    func retrieveToken()
    func removeToken()
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
                                    self.loginDidSucceed(with: fetchedData?.accessToken ?? "", completion: completion)
                                case .failure(let error):
                                    let message = self.messageForError(error)
                                    completion(.failure(message))
                                }
        })
    }
    
    func retrieveToken() {
        dependencies.sessionManager.retrieveSessionToken(completion: { response in
            switch response {
            case .success(let token):
                print("Current token is: \(token)")
            case .failure(let error):
                switch error {
                case .technical:
                    print("Cant read current token")
                case .tokenNotFound:
                    print("There is no stored token")
                }
            }
        })
    }
    
    func removeToken() {
        dependencies.sessionManager.removeCurrentToken(completion: { response in
            
        })
    }
    
    private func loginDidSucceed(with token: String, completion: @escaping LoginClientResponse) {
        dependencies.sessionManager.saveSessionToken(token, completion: { result in
            switch result {
            case .success:
                completion(.successful)
            case .error:
                completion(.failure(LoginCopies.appError))
                
            }
        })
        print("login successful: \n accessToken \(token)")
    }
    
    
    /// Converts networking error into intelligible text for the user.
    /// - Parameter error: Networking produced error-
    private func messageForError(_ error: NetworkingError) -> String {
        switch error {
        case .forbidden:
            return LoginCopies.invalidCredentials
        case .server:
            return LoginCopies.serverError
        case .networking(_):
            return LoginCopies.appError
        default:
            return LoginCopies.appError
        }
    }
}
