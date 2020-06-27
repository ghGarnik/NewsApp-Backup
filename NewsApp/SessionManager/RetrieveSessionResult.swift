//
//  RetrieveSessionResult.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

enum RetrieveSessionResult<Value> {
    case success(Value)
    case failure(SessionManagerError)
}

typealias RetrieveSessionResponse<Value> = (RetrieveSessionResult<Value>) -> ()
