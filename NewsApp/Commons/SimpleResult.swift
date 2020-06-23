//
//  SimpleResult.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum SimpleResult {
    case success
    case error
}

public typealias SimpleResponse = (SimpleResult) -> ()
