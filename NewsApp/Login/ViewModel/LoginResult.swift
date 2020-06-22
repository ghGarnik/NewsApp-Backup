//
//  LoginResult.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

enum LoginResult {
        case successful
        case failure(String)
    }

typealias LoginClientResponse = (LoginResult) -> ()
