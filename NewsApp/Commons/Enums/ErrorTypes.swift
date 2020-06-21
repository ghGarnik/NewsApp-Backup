//
//  ErrorTypes.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum NewsError: Error {
    case networking(_: String)
    case forbidden
    case server(error: Error)
    case unknownError
}
