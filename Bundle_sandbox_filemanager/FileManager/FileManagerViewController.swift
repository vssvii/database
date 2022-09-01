//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ibragim Assaibuldayev on 05.12.2021.
//

import UIKit
import SnapKit
import WebKit
import CoreTelephony


class FileManagerViewController: UIViewController {
    
    
    private enum CellReuseIdentifiers: String {
        case files
    }
    
    var fileManagerService: FileManagerServiceProtocol
    
    init(fileManagerService: FileManagerServiceProtocol) {
        self.fileManagerService = fileManagerService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var fileManagerTableView: UITableView = {
        let fileManagerTableView = UITableView()
        fileManagerTableView.dataSource = self
        fileManagerTableView.delegate = self
        fileManagerTableView.register(FileManagerTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.files.rawValue)
        return fileManagerTableView
    }()
    
    private func addNavigationButtons() {
        let createFolderButton = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .done, target: self, action: #selector(handleAddNewDirectoryTapped))
        let addPhotoButton = UIBarButtonItem(
            title: "Доб. фотографии", style: .plain, target: self, action: #selector(navigationAddPhotosTapped))
        navigationItem.rightBarButtonItems = [createFolderButton, addPhotoButton]
    }
    
    @objc func navigationAddPhotosTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @objc func handleAddNewDirectoryTapped() {
        
        let alertContoller = UIAlertController(title: "Напишите название папки", message: nil, preferredStyle: .alert)
        alertContoller.addTextField()
        
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { action in
            if let txtField = alertContoller.textFields?.first, let text = txtField.text {
                print("Text==>" + text)
                self.fileManagerService.contentsOfDirectory(at: text) { content in
                    print(content)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (_) in }

        alertContoller.addAction(confirmAction)
        alertContoller.addAction(cancelAction)
        present(alertContoller, animated: true, completion: nil)
    }
    
    private func obtainFiles() {
        
        let path = Bundle.main.resourcePath!
        
        self.fileManagerService.contentsOfDirectory(at: path) { content in
            print(content)
        }
    }
    
    func toAutoLayout() {
        view.addSubview(fileManagerTableView)
        
        fileManagerTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        toAutoLayout()
        
        addNavigationButtons()
    }
    

    struct Post {
    var title: String
    }
    
    var post = Post(title: "Пост")
}

extension FileManagerViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fm = FileManager.default
        
        let desktopURL = try! fm.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let content = Content.init(type: .folder(url: desktopURL), name: "Фотографии")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.files.rawValue, for: indexPath)
        switch content.type {
        case .folder:
            cell.accessoryType = .disclosureIndicator
        case .file:
            break
        }
        cell.textLabel?.text = content.name
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fm = FileManager.default
        
        let desktopURL = try! fm.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let data = Content.init(type: .folder(url: desktopURL), name: "Фотографии")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let fileManagerService = FileManagerService()
        
        let viewController = FileManagerViewController(fileManagerService: FileManagerService.self as! FileManagerServiceProtocol)

    }
    
}

extension FileManagerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        self.fileManagerService.createFile(at: picker.title) { file in
            print(file)
        }
    }
}

