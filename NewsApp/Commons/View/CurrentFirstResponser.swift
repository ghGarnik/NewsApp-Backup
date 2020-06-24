//
//  CurrentFirstResponser.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

extension UIView {
    func currentFirstResponder() -> UIResponder? {
        if isFirstResponder {
            return self
        }
        
        for view in subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        
        return nil
    }
}
