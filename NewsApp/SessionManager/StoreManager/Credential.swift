//
//  Credentials.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

enum CredentialType: String {
    case token = "sessionToken"
}

struct Credential {
    let type: CredentialType
    let value: String
}
