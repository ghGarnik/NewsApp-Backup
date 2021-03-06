//
//  ArticlesListRouterProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol ArticlesListRouterProtocol {
    func showMessage(_ message: String, completion: @escaping Action)
    func navigateToArticle(_: Int)
    func logoutDidSucceed()
}
