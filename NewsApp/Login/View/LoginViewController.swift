//
//  LoginViewController.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    
    //MARK: - Binding
    
    var viewModel: LoginViewModelProtocol?
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCaptions()
        configureTextfields()
        configureHeaderImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - View configuration
    
    private func configureCaptions() {
        userTextField.placeholder = Copies.user
        passwordTextField.placeholder = Copies.password
        loginButton.setTitle(Copies.login, for: .normal)
    }
    
    private func configureTextfields() {
        userTextField.tag = 0
        userTextField.tag = 1
    }
    
    private func configureHeaderImage() {
        headerImage.image = #imageLiteral(resourceName: "iPad")
        headerImage.contentMode = .scaleAspectFill
    }
    
    //MARK: - Actions
    
    @IBAction func login(_ sender: Any) {
        let username = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel?.didTapOnLogin(username: username, password: password)
    }
}
