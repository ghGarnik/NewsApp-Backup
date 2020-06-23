//
//  Credentials.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum CredentialType: String {
    case token = "sessionToken"
}

public struct Credential {
    let type: CredentialType
    let value: String
}
