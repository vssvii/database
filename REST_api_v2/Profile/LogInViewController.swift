//
//  LogInViewController.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 05.03.2022.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth
    


class LogInViewController: UIViewController, UITextFieldDelegate {
    
    public var delegate: LoginViewControllerDelegate?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init(with delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    
    private var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "profile")
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
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
        login.delegate = self
        login.translatesAutoresizingMaskIntoConstraints = false
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
        pass.delegate = self
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.placeholder = "Password"
        return pass
    }()
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = 10
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return signInButton
    }()
    
    private lazy var signUpButton: UIButton = {
        let changeButton = UIButton()
        changeButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        changeButton.setTitle("Sign Up", for: .normal)
        changeButton.layer.cornerRadius = 10
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return changeButton
    }()
    
    @objc func signInButtonPressed() {
        
        self.delegate?.checkCredentials(login: login.text!, password: pass.text!) { [self] result, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
            } else {
                #if DEBUG
                let logInProfile = ProfileViewController(userService: CurrentUserService(name: login.text!, avatar: "", status: "") as UserService, userName: login.text!)
                navigationController?.pushViewController(logInProfile, animated: true)
                #else
                let logInProfile = ProfileViewController(userService: TestUserService(name: login.text!, avatar: "", status: "") as UserService, userName: login.text!)
                navigationController?.pushViewController(logInProfile, animated: true)
                #endif
            }
        }
    }
    
    @objc func signUpButtonPressed() {
        
        self.delegate?.signUp(login: login.text!, password: pass.text!) { result, error in
            if let error = error as? NSError {
                print("Error: \(error.localizedDescription)")
            } else {
                print("User signs up successfully")
            }
        }
    }
    
    
    private func setupLayout() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(logo)
        scrollView.addSubview(login)
        scrollView.addSubview(pass)
        scrollView.addSubview(signInButton)
        scrollView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 100.0),
            logo.heightAnchor.constraint(equalToConstant: 100.0),
            
            login.topAnchor.constraint(equalTo: logo.topAnchor, constant: 120.0),
            login.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            login.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            login.heightAnchor.constraint(equalToConstant: 50),
            
            pass.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 0),
            pass.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            pass.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            pass.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.topAnchor.constraint(equalTo: pass.bottomAnchor, constant: 16.0),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16.0),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = true
        
        setupLayout()

    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
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
        
        Auth.auth().removeStateDidChangeListener(handle!)
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
