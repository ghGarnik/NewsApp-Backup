//
//  DefaultSessionManager.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

//MARK: - Dependencies

public protocol DefaultSessionManagerDependenciesProtocol {
    var credentialsStore: CredentialsStore { get }
    var cacheManager: CacheManagerProtocol{ get }
}

public class DefaultSessionManagerDependencies: DefaultSessionManagerDependenciesProtocol {
    public lazy var credentialsStore: CredentialsStore = DefaultCredentialsStore()
    public lazy var cacheManager: CacheManagerProtocol = CacheManager(dependencies: CacheManagerDependencies())
}


//MARK: - Implementation

public final class DefaultSessionManager: SessionManagerProtocol {
    
    private let dependencies: DefaultSessionManagerDependenciesProtocol
    
    public init(dependencies: DefaultSessionManagerDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    /// Saves session token to some secure storage.
    /// - Parameter token: Token to be saved.
    /// - Parameter completion: Closure that manages saving response.
    public func saveSessionToken(_ token: String, completion: @escaping SimpleResponse) {
        let credential = Credential(type: .token, value: token)
        
        dependencies.credentialsStore.updateCredential(credential,
                                                       completion: {response in
                                                        
                                                        switch response {
                                                        case .success:
                                                            completion(.success)
                                                        case .failure:
                                                            completion(.error)
                                                        }
        })
    }
    
    /// Retrieves saved token. If there is no token, or any error accessing it, forwards error.
    /// - Parameter completion: Closure that manages response.
    public func retrieveSessionToken(completion: @escaping RetrieveSessionResponse<String>) {
        dependencies.credentialsStore.retrieveCredential(.token,
                                                         completion: {response in
                                                            
                                                            switch response {
                                                            case .success(let token):
                                                                completion(.success(token))
                                                            case .failure(let credentialError):
                                                                if credentialError == .keyNotFound {
                                                                    completion(.failure(.tokenNotFound))
                                                                } else {
                                                                    completion(.failure(.technical))
                                                                }
                                                                
                                                            }
        })
    }
    
    public func removeCurrentToken(completion: @escaping SimpleResponse) {
        dependencies.credentialsStore.removeCredential(.token, completion: { [weak self] response in
            guard let self = self else { return }
            completion(response)
            self.dependencies.cacheManager.wipeAppCache()
        })
    }
    
    /// Retrieves if there is current session available.
    /// - Parameter completion: closure that manages rather the session is valid or not.
    public func isValidSession(completion: @escaping (Bool) -> ()) {
        retrieveSessionToken(completion: { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        })
    }
}

