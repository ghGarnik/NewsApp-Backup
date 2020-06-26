//
//  UICollectionView+DequeueCell.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueCell<T: NibReusable>(forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}
