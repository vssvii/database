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
import RealmSwift
import SnapKit
    


class LogInViewController: UIViewController {
    
    var isUserAuthorized: Bool = false
    
    let realm = try! Realm()
    
    typealias Callback = () -> Void
    
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
//        login.delegate = self
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
//        pass.delegate = self
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
        signInButton.addTarget(self, action: #selector(signInRealm), for: .touchUpInside)
        return signInButton
    }()
    
    private lazy var signUpButton: UIButton = {
        let changeButton = UIButton()
        changeButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        changeButton.setTitle("Sign Up", for: .normal)
        changeButton.layer.cornerRadius = 10
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.addTarget(self, action: #selector(signUpRealm), for: .touchUpInside)
        return changeButton
    }()
    
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: 20)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.numberOfLines = 10
        return errorLabel
    }()
    
    private lazy var checkInLabel: UILabel = {
        let checkInLabel = UILabel()
        checkInLabel.text = "Пароль должен быть не меньше 4 символов"
        checkInLabel.font = .boldSystemFont(ofSize: 15)
        checkInLabel.textColor = .red
        checkInLabel.isHidden = true
        checkInLabel.numberOfLines = 0
        return checkInLabel
    }()
    
    func presentAlert(title: String? = nil, message: String? = nil, completion: (Callback)? = nil) {
        let title = title ?? "Попробуйте снова!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            guard let completion = completion else { return }
            completion()
        }))
        present(alert, animated: true)
    }
    
    let authRealm = AuthRealm()
    
    @objc func signInRealm() {
        
        let authObjects = realm.objects(AuthRealm.self)
        for authObject in authObjects {
            let userName = authObject.userName
            let password = authObject.password
//            var isAuthorized = authObject.isUserAuthorized
            if login.text ?? "" == userName && pass.text ?? "" == password {
//                isAuthorized = true
                    #if DEBUG
                    let logInProfile = ProfileViewController(userService: CurrentUserService(name: login.text ?? "", avatar: "", status: "") as UserService, userName: login.text ?? "")
                    navigationController?.pushViewController(logInProfile, animated: true)
                    #else
                    let logInProfile = ProfileViewController(userService: TestUserService(name: login.text ?? "", avatar: "", status: "") as UserService, userName: login.text ?? "")
                    navigationController?.pushViewController(logInProfile, animated: true)
                    #endif
            } else {
                checkInLabel.text = "Неправильный логин и/или пароль!"
                checkInLabel.isHidden = false
                    self.login.text = nil
                    self.pass.text = nil
            }
        }
    }
    
    func isAuthorized() {
        let authObjects = realm.objects(AuthRealm.self)
        for authObject in authObjects {
            if authObject.userName != nil {
                #if DEBUG
                let logInProfile = ProfileViewController(userService: CurrentUserService(name: login.text ?? "", avatar: "", status: "") as UserService, userName: login.text ?? "")
                navigationController?.pushViewController(logInProfile, animated: true)
                #else
                let logInProfile = ProfileViewController(userService: TestUserService(name: login.text ?? "", avatar: "", status: "") as UserService, userName: login.text ?? "")
                navigationController?.pushViewController(logInProfile, animated: true)
                #endif
            } else {
                print("Пользователь не авторизован. Авторизуйтесь!")
            }
        }
    }
    
    @objc func signUpRealm() {
        let authObjects = realm.objects(AuthRealm.self)
        
        authRealm.userName = login.text ?? ""
        authRealm.password = pass.text ?? ""
//        authRealm.isUserAuthorized = false
        
        presentAlert(title: "", message: "Регистрация прошла успешна!")
        try! self.realm.write( {
            self.realm.add(self.authRealm)
        })
    }

    
    private func setupLayout() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(login)
        contentView.addSubview(pass)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
        contentView.addSubview(checkInLabel)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(120)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        login.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.height.equalTo(50)
        }
        
        pass.snp.makeConstraints { (make) in
            make.top.equalTo(login.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(pass.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(signInButton.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
            make.height.equalTo(50)
        }
        
        checkInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(signUpButton.snp.bottom).offset(16)
            make.centerX.equalTo(contentView)
            make.height.equalTo(30)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = true
        
        setupLayout()
        
        isAuthorized()
        print(realm.configuration.fileURL)
        
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
