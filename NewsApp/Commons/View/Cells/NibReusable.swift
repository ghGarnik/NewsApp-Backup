//
//  NibReusable.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

protocol NibReusable: Reusable {
    static var nib: UINib { get }
}

extension NibReusable {
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    func initFromNib<T: NibReusable>(cellType: T.Type) -> UIView? {
        return cellType.nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
