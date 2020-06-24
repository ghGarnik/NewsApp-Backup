//
//  LoginCopies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

enum LoginCopies {
    static let user = "your username"
    static let password = "type here your password"
    static let login = "Login >"
    static let done = "Done"
    static let retrieveToken = "Retrieve Token"
    static let logout = "Logout"
}

//MARK: - Login Errors

extension LoginCopies {
    static let invalidCredentials = "Upps...Your username or password seems to be wrong."
    static let serverError = "Server is just waking up from a short nap. Try again later."
    static let appError = "Our developers are not inspired today. Try again. If it persists, please contact us"
}
