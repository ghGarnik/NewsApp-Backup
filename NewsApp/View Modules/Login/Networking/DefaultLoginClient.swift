//
//  LoginClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

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
                                            completion: { [weak self] response in
                                                guard let self = self else { return }

                                                switch response {
                                                case .successful(let fetchedData):
                                                    self.loginDidSucceed(with: fetchedData?.accessToken ?? "", completion: completion)
                                                case .failure(let error):
                                                    let message = self.messageForError(error)
                                                    completion(.failure(message))
                                                }
        })
    }

    private func loginDidSucceed(with token: String, completion: @escaping LoginClientResponse) {
        dependencies.sessionManager.saveSessionToken(token, completion: { result in
            switch result {
            case .success:
                completion(.successful)
            case .error:
                completion(.failure(CommonCopies.appError))

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
            return CommonCopies.serverError
        case .networking(_):
            return CommonCopies.appError
        default:
            return CommonCopies.appError
        }
    }
}
