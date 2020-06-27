//
//  LoginRequest.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 20/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

final class LoginRequest: APIRequest {

    typealias Response = LoginResponse?

    let path: Path
    var method: HTTPMethods { return .post}
    var headers: Headers { return nil }
    var encoding: HTTPEncoding { return .jsonEncoding}
    var auth: Bool { return false }

    init(path: Path) {
        self.path = path
    }

}
