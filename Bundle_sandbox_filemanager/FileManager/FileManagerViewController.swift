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
    
    var contents = [Content]()
    
    var contentFolder = Content(type: .folder(url: URL(string: "")), name: "")
    
    var contentFile = Content(type: .file(url: URL(string: "")), name: "")
    
    var content: Content
    
    let fileManager = FileManager.default
    
    let fileManagerService: FileManagerService
    
    init(fileManagerService: FileManagerService, content: Content) {
        self.fileManagerService = fileManagerService
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum CellReuseIdentifiers: String {
        case files
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
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    @objc func handleAddNewDirectoryTapped() {
        
        let alertContoller = UIAlertController(title: "Напишите название папки", message: nil, preferredStyle: .alert)
        alertContoller.addTextField()
        
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { [self] action in
            if let txtField = alertContoller.textFields?.first, let text = txtField.text {
                print("Text==>" + text)
                
                let folderName = UUID().uuidString
                
                let folderPath = self.getDocumentsDirectory().appendingPathComponent(folderName)
                
                try! fileManager.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: [:])
                
                contentFolder.name = text
                    
                contents.append(contentFolder)
                
                fileManagerTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (_) in }

        alertContoller.addAction(confirmAction)
        alertContoller.addAction(cancelAction)
        present(alertContoller, animated: true, completion: nil)
    }
    
    private func obtainFiles() {
        
        let path = Bundle.main.resourcePath!
        
        
        self.fileManagerService.contentsOfDirectory(at: path) { result in
            
            print("Result:\(result)")
            
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
    
    func getDocumentsDirectory() -> URL {
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: contents, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "contents")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        toAutoLayout()
        
        addNavigationButtons()
        
        obtainFiles()
    }
    

    struct Post {
    var title: String
    }
    
    var post = Post(title: "Пост")

}


   // MARK: Table view data source
    
extension FileManagerViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "File Manager"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.files.rawValue, for: indexPath) as? FileManagerTableViewCell
        
        let content = contents[indexPath.item]
        cell?.textLabel?.text = content.name
        
        let path = getDocumentsDirectory().appendingPathComponent(content.name)
        cell?.imageView?.image = UIImage(contentsOfFile: path.path)
        
        cell?.imageView?.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell?.imageView?.layer.borderWidth = 2
        cell?.imageView?.layer.cornerRadius = 3
        cell!.layer.cornerRadius = 7
        
        switch content.type {
        case .folder:
            cell!.accessoryType = .disclosureIndicator
        case .file: break
        }
        cell?.textLabel?.text = content.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.fileManagerTableView.deselectRow(at: indexPath, animated: true)
        
        let data = contents
        
        guard case Content.ContentType.folder = data[indexPath.row].type else {
        return
        }
        
        let fileManagerService = FileManagerService()
        
        let contentFiles = contentFile
        
        let viewController = FileManagerViewController(fileManagerService: fileManagerService, content: contentFiles)
        
        fileManagerTableView.reloadData()
        
        present(viewController, animated: true)
        
    }
    
}

extension FileManagerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = "Фото"
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        contentFile.name = imageName
        
        contents.append(contentFile)

        fileManagerTableView.reloadData()
        
        dismiss(animated: true)
    }
}
