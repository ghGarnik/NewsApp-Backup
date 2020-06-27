//
//  CredentialsManager.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol CredentialsStore {
    func updateCredential(_ credential: Credential, completion: @escaping UpdateCredentialResponse)
    func retrieveCredential(_ credential: CredentialType, completion: @escaping RetrieveCredentialResponse<String>)
    func removeCredential(_ credential: CredentialType, completion: @escaping SimpleResponse)
}
