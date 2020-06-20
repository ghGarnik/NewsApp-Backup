//
//  Login.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 20/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

struct Login {
    let username: String
    let password: String
    let grantType: GrantType = .password
    
    func toParammeters() -> Parameters {
        let parameters = ["username": username,
                          "password": password,
                          "grant_type": grantType.rawValue]
        return parameters
    }
}

enum GrantType: String {
    case password = "password"
}
