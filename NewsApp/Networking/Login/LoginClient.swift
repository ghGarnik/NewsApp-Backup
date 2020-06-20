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

class LoginClient {
    //private var activeRequest: Request?
    //private let currentQueue: OperationQueue
    private let sessionManager: HTTPClient
    
    public init(sessionManager: HTTPClient = DefaultHTTPClient()) {
        self.sessionManager = sessionManager
    }
    
    public func login(_ loginSettings: Login) {
        let url = Endpoints.login.url
        let request = LoginRequest(path: url)
        
        sessionManager.execute(request,
                               parameters: loginSettings.toParammeters(),
                               completion: { response in
                                switch response {
                                case .successful(let fetchedData):
                                    print("login successful: \n accessToken \(fetchedData?.accessToken ?? "") \n refreshToken: \(fetchedData?.refreshToken ?? "")")
                                case .failure(let error):
                                    print("login error: \(error)")
                                }
        })
    }
}
