//
//  LogInViewController.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 05.03.2022.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: LoginViewControllerDelegate?
    
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    public lazy var contentView: UIView = {
        let contenView = UIView()
        contenView.backgroundColor = .white
        contenView.translatesAutoresizingMaskIntoConstraints = false
        return contenView
    }()
    
    public lazy var login: UITextField = {
        let login = UITextField()
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.5
        login.layer.cornerRadius = 10
        login.backgroundColor = .systemGray6
        login.textColor = .black
        login.font = .systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.autocorrectionType = UITextAutocorrectionType.no
        login.keyboardType = UIKeyboardType.default
        login.returnKeyType = UIReturnKeyType.done
        login.clearButtonMode = UITextField.ViewMode.whileEditing
        login.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        login.placeholder = "Login or email"
        return login
    }()
    
    public lazy var pass: UITextField = {
        let pass = UITextField()
        pass.layer.borderColor = UIColor.lightGray.cgColor
        pass.layer.borderWidth = 0.5
        pass.layer.cornerRadius = 10
        pass.backgroundColor = .systemGray6
        pass.textColor = .black
        pass.font = .systemFont(ofSize: 16)
        pass.autocapitalizationType = .none
        pass.isSecureTextEntry = true
        pass.autocorrectionType = UITextAutocorrectionType.no
        pass.keyboardType = UIKeyboardType.default
        pass.returnKeyType = UIReturnKeyType.done
        pass.clearButtonMode = UITextField.ViewMode.whileEditing
        pass.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        pass.placeholder = "Password"
        return pass
    }()
    
    private let inspector: LoginViewControllerDelegate
    
    init(inspector: LoginViewControllerDelegate) {
        self.inspector = inspector
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        scrollView.addSubview(logo)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0).isActive = true
        logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        login.delegate = self
        scrollView.addSubview(login)
        
        login.translatesAutoresizingMaskIntoConstraints = false
        login.topAnchor.constraint(equalTo: logo.topAnchor, constant: 120.0).isActive = true
        login.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        login.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        login.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pass.delegate = self
        scrollView.addSubview(pass)
        
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 0).isActive = true
        pass.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        pass.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        pass.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let logInButton = UIButton()
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logInButton.setTitle("Log In", for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        scrollView.addSubview(logInButton)
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.topAnchor.constraint(equalTo: pass.bottomAnchor, constant: 16.0).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func logInPressed() {
        #if DEBUG
        let logInProfile = ProfileViewController(userService: CurrentUserService(name: login.text!, avatar: "", status: "") as UserService, userName: login.text!)
        navigationController?.pushViewController(logInProfile, animated: true)
        #else
        let logInProfile = ProfileViewController(userService: TestUserService(name: login.text!, avatar: "", status: "") as UserService, userName: login.text!)
        navigationController?.pushViewController(logInProfile, animated: true)
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func update(title: String) {
        navigationItem.title = title
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom += (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
}

extension LogInViewController: LoginViewControllerDelegate {
    func logInChecker(userName: String, password: String) -> Bool {
        if userName == Checker.shared.login && password == Checker.shared.pswd {
            return true
        } else {
            return false
        }
    }
}
