//
//  ViewController.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 19/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    enum Copies: String {
        case user = "your username"
        case password = "type here your password"
        case login = "Login >"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCaptions()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func configureCaptions() {
        userTextField.placeholder = Copies.user.rawValue
        passwordTextField.placeholder = Copies.password.rawValue
        loginButton.titleLabel?.text = Copies.login.rawValue
    }

    @IBAction func login(_ sender: Any) {
        let username = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let login = Login(username: username, password: password)
        let loginClient = LoginClient()
        loginClient.login(login)
    }
}

