//
//  LoginViewController.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AlertShowing {
    
    //MARK: - Outlets
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var retrieveTokenButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    //MARK: - Binding
    
    var viewModel: LoginViewModelProtocol?
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCaptions()
        configureTextfields()
        configureDelegates()
        configureHeaderImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
        setupScrollViewGesture()
        checkLoginButtonState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    //MARK: - View configuration
    
    private func configureCaptions() {
        userTextField.placeholder = LoginCopies.user
        passwordTextField.placeholder = LoginCopies.password
        loginButton.setTitle(LoginCopies.login, for: .normal)
        
        retrieveTokenButton.setTitle(LoginCopies.retrieveToken, for: .normal)
        logoutButton.setTitle(LoginCopies.logout, for: .normal)
    }
    
    private func configureTextfields() {
        userTextField.tag = 0
        passwordTextField.tag = 1
        
        userTextField.inputAccessoryView = setDoneOnKeyboard()
        passwordTextField.inputAccessoryView = setDoneOnKeyboard()
    }
    
    private func configureDelegates() {
        userTextField.delegate = self
        passwordTextField.delegate = self
        loginScrollView.delegate = self
    }
    
    private func configureHeaderImage() {
        headerImage.image = #imageLiteral(resourceName: "iPad")
        headerImage.contentMode = .scaleAspectFill
    }
    
    
    /// Adds a gesture recognizer for dismissing keyboard when tapping on the screen.
    private func setupScrollViewGesture() {
        let tapScroll = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        tapScroll.cancelsTouchesInView = false
        
        loginScrollView.addGestureRecognizer(tapScroll)
    }
    
    //MARK: - Actions
    
    @IBAction func login(_ sender: Any) {
        let username = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel?.didTapOnLogin(username: username, password: password)
    }
    
    @IBAction func retrieveToken(_ sender: Any) {
        viewModel?.didTapOnRetrieveToken()
    }
    
    @IBAction func logout(_ sender: Any) {
        viewModel?.didTapOnLogout()
    }
}

//MARK: - Login Button State

extension LoginViewController {
    
    /// Sets Login Button state regarding user credentials.
    private func checkLoginButtonState() {
        let userText = userTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        loginButton.isEnabled = !userText.isEmpty && !passwordText.isEmpty
    }
}

//MARK: - Textfield Delegate

extension LoginViewController: UITextFieldDelegate {
    
    /// Allows start editing next textfield when user taps on return on keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case userTextField, passwordTextField:
            checkLoginButtonState()
        default:
            debugPrint("Unknown uitextfield")
        }
        
        return true
    }
}


//MARK: - ScrillView Delegate

extension LoginViewController: UIScrollViewDelegate {
    
    /// Avoids top bouncing.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0) , animated: false)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

//MARK: - Keyboard

extension LoginViewController {
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    ///Adds "done" button on top of keyboard, to help user to know an explicit way to finish editing.
    private func setDoneOnKeyboard() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: LoginCopies.done, style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([flexBarButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }
    
    /// Scrolls up the view to avoid textfields to be hidden under keyboard. This function listens to keyboard notification.
    /// - Parameter notification: keyboard notification
    @objc private func keyboardDidShow(notification: NSNotification) {
        guard let keyboardUserInfo = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject? else {
            return
        }
        
        let keyboardSize = keyboardUserInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        loginScrollView.contentInset = contentInsets
        loginScrollView.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        
        if let textField = view.currentFirstResponder() as? UITextField,
            viewRect.contains(textField.frame.origin) {
            let scrollPoint = CGPoint(x: 0, y: textField.frame.origin.y)
            loginScrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Resets scrollView content insets.
    @objc private func keyboardWillHide() {
        loginScrollView.contentInset = .zero
        loginScrollView.scrollIndicatorInsets = .zero
    }
}
