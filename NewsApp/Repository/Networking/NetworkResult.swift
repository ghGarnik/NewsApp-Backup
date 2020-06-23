//
//  Result.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum NetworkResult<Value> {
    case successful(Value)
    case failure(NetworkingError)
}

public typealias NetworkResponse<Value> = (NetworkResult<Value>) -> ()
