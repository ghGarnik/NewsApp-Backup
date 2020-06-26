//
//  Endpoints.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 20/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum Endpoints {
    case login
    case articlesList
    
    private var baseURL: String { return "https://mobilecodetest.fws.dev"}
    private var path: String {
        switch self {
        case .login:
            return "/auth/token"
        case .articlesList:
            return "/api/v1/articles"
        }
    }
    //MARK: - Full path Generation
    
    var url: String {
        return baseURL.appending(self.path)
    }
}
