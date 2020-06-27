//
//  Styles.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

enum ArticleStyle {
    case title
    case body
    case date

    var textColor: UIColor {
        switch self {
        case .title:
            return .black
        case .body:
            return .darkGray
        case .date:
            return .lightGray
        }
    }

    var font: UIFont {
        switch self {
        case .title:
            return UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .title3),
                          size: 14)
        case .body:
            return UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body),
            size: 12)
        case .date:
            return UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .footnote),
            size: 10)
        }
    }

    var numberOfLines: Int {
        switch self {
        case .title:
            return 2
        case .body:
            return 0
        case .date:
            return 1
        }
    }

    var textAlignment: NSTextAlignment {
        switch self {
        case .title, .body:
            return .left
        case .date:
            return .center
        }
    }

}

extension UILabel {
    func applyStyle(_ style: ArticleStyle) {
        self.font = style.font
        self.textColor = style.textColor
        self.numberOfLines = style.numberOfLines
        self.textAlignment = .left
    }
}

extension UIView {
    func roundCodners() {
        self.layer.cornerRadius = 6.0
    }
}
