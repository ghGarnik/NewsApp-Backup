//
//  Coordinator.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
    func loginDidSucceed()
    func logoutDidSucceed()
    func openArticle(withId _: Int)
}
