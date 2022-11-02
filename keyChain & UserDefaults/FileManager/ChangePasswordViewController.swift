//
//  ChangePasswordViewController.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 02.11.2022.
//

import UIKit
import KeychainSwift
import SnapKit

class ChangePasswordViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    typealias Callback = () -> Void
    
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
        signInButton.setTitle("Сменить пароль", for: .normal)
        signInButton.isHidden = false
        signInButton.addTarget(self, action: #selector(setPassword), for: .touchUpInside)
        return signInButton
    }()
    
    private lazy var checkInLabel: UILabel = {
        let checkInLabel = UILabel()
        checkInLabel.text = "Пароль должен быть не меньше 4 символов"
        checkInLabel.textColor = .red
        checkInLabel.isHidden = true
        checkInLabel.numberOfLines = 0
        return checkInLabel
    }()
    
    public lazy var confirmationButton: UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.backgroundColor = .blue
        confirmationButton.setTitle("Повторите пароль", for: .normal)
        confirmationButton.isHidden = true
        confirmationButton.addTarget(self, action: #selector(confirmPassword), for: .touchUpInside)
        return confirmationButton
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
            defaults.set(password, forKey: "password")
            signInButton.isHidden = true
            confirmationButton.isHidden = false
            checkInLabel.isHidden = true
        }
    }
    
    @objc func confirmPassword() {
        guard let password = self.password.text else { return }
        if password == defaults.string(forKey: "password") {
            presentAlert(title: "", message: "Пароль успешно сменен!") {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.presentAlert(title: "", message: "Неправильный пароль!") {
                self.defaults.removeObject(forKey: "password")
                self.signInButton.isHidden = false
                self.confirmationButton.isHidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Смена пароля"
        
        
        view.addSubview(password)
        password.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(200)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
