//
//  ArticleDetailRouterProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol ArticleDetailRouterProtocol {
    func showMessage(_ message: String, completion: @escaping Action)
    func logoutDidSucceed()
}
