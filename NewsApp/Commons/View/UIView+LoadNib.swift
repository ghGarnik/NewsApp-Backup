//
//  UIView+LoadNib.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

import UIKit

extension UIView {

    /// Loads instance from nib with the same name.
    func loadNibForUIView() {
        let bundle = Bundle(for: type(of: self))
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else { return }
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        customView.frame = self.bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(customView)
    }
}
