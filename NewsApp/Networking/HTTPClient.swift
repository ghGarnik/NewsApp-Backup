//
//  HTTPClient.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public typealias Path = String
public typealias Parameters = [String: Any]?
public typealias Headers = [String: String]?

public class LoginClient {
    //private var activeRequest: Request?
    //private let currentQueue: OperationQueue
    private let baseURL: String
    private let sessionManager: SessionManager

    public init(baseURL: String,
                sessionManager: SessionManager = DefaultSessionManager()) {
        self.baseURL = baseURL
        self.sessionManager = sessionManager
    }
}
