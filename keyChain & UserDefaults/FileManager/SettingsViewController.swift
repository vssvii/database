//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 02.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var contentFolder = Content(type: .folder(url: URL(string: "")), name: "")
    
    var contentFile = Content(type: .file(url: URL(string: "")), name: "")
    
    private lazy var fileManagerService: FileManagerService = {
        let fileManagerService = FileManagerService()
        return fileManagerService
    }()
    
    private lazy var sortButton: UIButton = {
        let sortButton = UIButton()
        sortButton.backgroundColor = .blue
        sortButton.setTitle("Отсортировать", for: .normal)
        sortButton.addTarget(self, action: #selector(sortFiles), for: .touchUpInside)
        return sortButton
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let changePasswordButton = UIButton()
        changePasswordButton.backgroundColor = .blue
        changePasswordButton.setTitle("Поменять пароль", for: .normal)
        changePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return changePasswordButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fixView()
    }
    
    @objc func sortFiles() {
        let fileManagerVC = FileManagerViewController(fileManagerService: fileManagerService, content: contentFolder)
        let contents = fileManagerVC.contents
        contents.sorted {
            $0.name < $1.name
        }
    }
    
    @objc func changePassword() {
        let changePassVC = ChangePasswordViewController()
        navigationController?.pushViewController(changePassVC, animated: true)
    }
    
    private func fixView() {
        view.backgroundColor = .white
        title = "Настройки"
        
        view.addSubview(sortButton)
        sortButton.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        view.addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(sortButton.snp.bottom).offset(50)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }

}
