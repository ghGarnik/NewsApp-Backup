//
//  DefaultCredentialsStore.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation
import Security

final class DefaultCredentialsStore: CredentialsStore {
    private enum Constants {
        static let stringEncoding: String.Encoding = .utf8
    }

    init() {

    }

    /// Updates Keychain stored credential. If the credential already exists, it updates the value.
    /// - Parameter credential: Credential object containing type and value to update.
    /// - Parameter completion: Closures that manages updating result.
    func updateCredential(_ credential: Credential, completion: @escaping UpdateCredentialResponse) {
        retrieveCredential(credential.type, completion: { [weak self] response in
            guard let self = self else { return }

            if case .success = response {
                self.removeCredential(credential.type, completion:  { _ in })
            }
            self.saveCredential(credential, completion: completion)
        })
    }

    /// Stores credential in KeyChain. If it already exists, completes with error.
    /// - Parameter credential: Credential object containing type and value to store.
    /// - Parameter completion: Closure that manages saving result.
    private func saveCredential(_ credential: Credential, completion: @escaping UpdateCredentialResponse) {
        guard let securedValue = credential.value.data(using: Constants.stringEncoding) else {
            completion(.failure(.writting))
            return
        }

        let credentialType = credential.type.rawValue
        let query:  [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrGeneric as String: credentialType,
                                     kSecValueData as String: securedValue]
        let status = SecItemAdd(query as CFDictionary, nil)

        if status == noErr {
            completion(.success)
        } else {
            completion(.failure(.writting))
        }
    }

    /// Retrieves credential for a credential type. If it doesn't exist, completes with error.
    /// - Parameter credential: Credential type to retrieve.
    /// - Parameter completion: Closure that manages retrieveing.
    func retrieveCredential(_ credential: CredentialType, completion: @escaping RetrieveCredentialResponse<String>) {
        let credentialType = credential.rawValue
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrGeneric as String: credentialType,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == noErr else {
            completion(.failure(.keyNotFound))
            return
        }

        if let existingItem = item as? [String: Any],
            let codedCredential = existingItem[kSecValueData as String] as? Data,
            let decodedCredential = String(data: codedCredential, encoding: Constants.stringEncoding) {
            completion(.success(decodedCredential))
        } else {
            completion(.failure(.keyNotFound))
        }
    }

    /// Removes existing credential from Keychain. If the credential actually doesn't exist, it also completes with success.
    /// - Parameter credential: Credential type to remove.
    /// - Parameter completion: Closure that manages removing.
    func removeCredential(_ credential: CredentialType, completion: @escaping SimpleResponse) {
        retrieveCredential(credential, completion: { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success:
                self.deleteCredential(credential, completion: completion)
            case .failure(let error):
                if case .keyNotFound = error {
                    completion(.success)
                } else {
                    completion(.error)
                }
            }
        })
    }

    private func deleteCredential(_ credential: CredentialType, completion: @escaping SimpleResponse) {
        let credentialType = credential.rawValue
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrGeneric as String: credentialType]
        let status = SecItemDelete(query as CFDictionary)

        guard status == noErr else {
            completion(.error)
            return
        }

        completion(.success)
    }
}
