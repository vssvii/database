//
//  ProfileHeaderView.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 18.01.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    public var statusText: String?
    
    private var statusLabel: UILabel = {
       let statusLabel = UILabel()
        statusLabel.textAlignment = .center
        statusLabel.font = .boldSystemFont(ofSize: 14)
        statusLabel.textColor = .gray
        statusLabel.text = "Напишите статус"
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
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
    
    private var setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.backgroundColor = .blue
        setStatusButton.setTitle("Показать статус", for: .normal)
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        return setStatusButton
    }()
    
    private var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Ibragim"
        fullNameLabel.font = .boldSystemFont(ofSize: 18)
        fullNameLabel.textAlignment = .center
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
        
    private var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.backgroundColor = .white
        statusTextField.textColor = .black
        statusTextField.font = .boldSystemFont(ofSize: 15)
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        statusTextField.keyboardAppearance = .default
        statusTextField.keyboardType = .default
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        return statusTextField
    }()
    
    private var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.backgroundColor = .systemRed
        closeButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        closeButton.layer.shadowRadius = 3
        closeButton.layer.shadowColor = UIColor.black.cgColor
        closeButton.layer.shadowOpacity = 0.9
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        self.addSubview(avatarImageView)
        self.addSubview(setStatusButton)
        self.addSubview(fullNameLabel)
        self.addSubview(statusTextField)
        self.addSubview(statusLabel)
        self.addSubview(closeButton)
        
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.leading.equalToSuperview().inset(16.0)
            make.width.height.equalTo(110.0)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-16.0)
            make.leading.equalToSuperview().inset(16.0)
            make.trailing.equalToSuperview().inset(16.0)
            make.height.equalTo(50.0)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-27.0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.bottom.equalTo(setStatusButton.snp.top).inset(-16.0)
            make.left.equalTo(avatarImageView.snp.right).inset(-16.0)
            make.right.equalToSuperview().inset(16.0)
            make.height.equalTo(40.0)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.leading).inset(16)
            make.right.equalToSuperview()
            make.bottom.equalTo(statusTextField.snp.bottom)
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) -> String? {
        statusText = textField.text
        return statusText
    }
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
    }
}


