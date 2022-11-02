//
//  SignInViewController.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 29.10.2022.
//

import UIKit
import SnapKit
import KeychainSwift


class SignInViewController: UIViewController {
    
    
    let keyChain = KeychainSwift()
    
    typealias Callback = () -> Void
    
    var content = Content(type: .file(url: URL(string: "")), name: "")
    
    let fileManagerService = FileManagerService()
    
    private lazy var signInImage: UIImageView = {
        let signInImage = UIImageView()
        signInImage.image = UIImage(named: "icon")
        return signInImage
    }()
    
    private lazy var signInLabel: UILabel = {
        let signInLabel = UILabel()
        signInLabel.text = "Напишите пароль"
        signInLabel.numberOfLines = 0
        return signInLabel
    }()
    
    private lazy var password: UITextField = {
        let password = UITextField()
        password.backgroundColor = .white
        password.layer.borderColor = UIColor.black.cgColor
        password.layer.borderWidth = 1
        password.keyboardAppearance = .default
        password.keyboardType = .default
//        password.delegate = self
        return password
    }()
    
    
    
    public lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.backgroundColor = .blue
        signInButton.setTitle("Создать пароль", for: .normal)
        signInButton.isHidden = false
        signInButton.addTarget(self, action: #selector(setPassword), for: .touchUpInside)
        return signInButton
    }()
    
    public lazy var confirmationButton: UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.backgroundColor = .blue
        confirmationButton.setTitle("Напишите пароль", for: .normal)
        confirmationButton.isHidden = true
        confirmationButton.addTarget(self, action: #selector(confirmPassword), for: .touchUpInside)
        return confirmationButton
    }()
    
    private lazy var checkInLabel: UILabel = {
        let checkInLabel = UILabel()
        checkInLabel.text = "Пароль должен быть не меньше 4 символов"
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
    
    @objc func setPassword() {
        guard let password = self.password.text else { return }
        if password.count <= 4 {
            checkInLabel.isHidden = false
        } else {
            keyChain.set(password, forKey: "password")
            signInButton.isHidden = true
            confirmationButton.isHidden = false
            checkInLabel.isHidden = true
        }
    }
    
    let fileManagerBarItem = UITabBarItem()
    let settingsBarItem = UITabBarItem()
    
    func setTabBarItems() {
        fileManagerBarItem.title = "Файл менеджера"
        fileManagerBarItem.image = UIImage(systemName: "folder")
        
        settingsBarItem.title = "Настройки"
        settingsBarItem.image = UIImage(systemName: "gear")
    }
    
    @objc func confirmPassword() {
        guard let password = self.password.text else { return }
        if password == keyChain.get("password") {
            let fileManagerVC = FileManagerViewController(fileManagerService: fileManagerService, content: content)
            fileManagerVC.tabBarItem = fileManagerBarItem
            let fileManagerNC = UINavigationController(rootViewController: fileManagerVC)
            let settingsVC = SettingsViewController()
            settingsVC.tabBarItem = settingsBarItem
            let settingsNC = UINavigationController(rootViewController: settingsVC)
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [fileManagerNC, settingsNC]
//            tabBarController.selectedIndex = 0
//            navigationController?.pushViewController(tabBarController, animated: true)
            present(tabBarController, animated: true, completion: nil)
        } else {
            self.presentAlert(title: "", message: "Неправильный пароль!") {
                self.keyChain.delete("password")
                self.signInButton.isHidden = false
                self.confirmationButton.isHidden = true
            }
        }
    }
    
    private func setupView() {
        view.addSubview(signInImage)
        view.backgroundColor = .white
        signInImage.snp.makeConstraints { (make) -> Void in
           make.width.height.equalTo(100)
            make.centerX.equalTo(view)
            make.top.equalToSuperview().offset(250)
        }
        
        view.addSubview(signInLabel)
        signInLabel.snp.makeConstraints { (make) -> Void in
//            make.height.width.equalTo(100)
            make.top.equalTo(signInImage.snp.bottom).offset(16)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(password)
        password.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(signInLabel.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.height.equalTo(30)
            make.width.equalTo(300)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(password.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        view.addSubview(checkInLabel)
        checkInLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(signInButton.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        view.addSubview(confirmationButton)
        confirmationButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(password.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setTabBarItems()
    }
}
