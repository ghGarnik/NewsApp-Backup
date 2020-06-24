//
//  Coordinator.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

public protocol Coordinator: class {
    func start()
    func loginDidSucceed()
    func logoutDidSucceed()
}
