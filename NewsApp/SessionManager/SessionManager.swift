//
//  SessionManager.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol SessionManagerProtocol {
    func saveSessionToken(_ token: String, completion: @escaping SimpleResponse)
    func retrieveSessionToken(completion: @escaping RetrieveSessionResponse<String>)
    func isValidSession(completion: @escaping (Bool) -> ())
    func removeCurrentToken(completion: @escaping SimpleResponse)
}
