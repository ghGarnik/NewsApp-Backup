//
//  HTTPStatus.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 20/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

enum HTTPStatus {
    static let  valid = 200...299
    static let forbidden = 400...499
    static let serverError = 500...599
}
