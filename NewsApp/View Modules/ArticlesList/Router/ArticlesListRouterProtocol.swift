//
//  ArticlesListRouterProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol ArticlesListRouterProtocol {
    func showError(_ message: String, completion: @escaping Action)
    func logoutDidSucceed()
}
