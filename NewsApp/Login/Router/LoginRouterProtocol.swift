//
//  LoginRouterProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol LoginRouterProtocol {
    func loginDidSucceed()
    func loginDidFail(message: String)
}
