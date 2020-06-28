//
//  MockDefaultSessionManager.swift
//  NewsAppTests
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 28/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation
@testable import NewsApp

final class MockDefaultSessionManager: SessionManagerProtocol {
    
    private var sessionToken: String = ""
    
    private let behavior: Behavior
    
    init(behavior: Behavior) {
        self.behavior = behavior
    }
    
    func saveSessionToken(_ token: String, completion: @escaping SimpleResponse) {
        guard case .success = behavior else {
            completion(.error)
            return
        }
        
        sessionToken = token
        completion(.success)
    }
    
    func retrieveSessionToken(completion: @escaping RetrieveSessionResponse<String>) {
        guard case .success = behavior else {
            completion(.failure(.tokenNotFound))
            return
        }
        
        if sessionToken.isEmpty {
            sessionToken = "asdf"
        }
        completion(.success(sessionToken))
    }
    
    func isValidSession(completion: @escaping (Bool) -> ()) {
        guard case .success = behavior else {
            completion(false)
            return
        }
        
        completion(true)
    }
    
    func removeCurrentToken(completion: @escaping SimpleResponse) {
        guard case .success = behavior else {
            completion(.error)
            return
        }
        
        completion(.success)
    }
}
