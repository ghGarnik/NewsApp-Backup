//
//  AlertShowing.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 22/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

public protocol AlertShowing {
    func alert(_ message: String?, completion: Action?)
}

extension AlertShowing where Self: UIViewController {
    
    /// Shows an alert to the user.
    /// - Parameter message: Alert text.
    public func alert(_ message: String?, completion: Action? = nil){
        let alert = UIAlertController(title: nil,
                                      message: message ?? CommonCopies.unknownAlert,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: CommonCopies.ok,
                                        style: .default,
                                        handler: { _ in completion?()})
        
        alert.view.layer.cornerRadius = 15
        
        DispatchQueue.main.async {
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
    }
}


