//
//  Update
//  CredentialResult.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public enum UpdateCredentialResult {
    case success
    case failure(CredentialsStoreError)
}

public typealias UpdateCredentialResponse = (UpdateCredentialResult) -> ()
