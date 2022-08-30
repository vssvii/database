//
//  FolderViewController.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 16.08.2022.
//

import UIKit

class FolderViewController: UIViewController {

    
    private lazy var folderTableView: UITableView = {
        let folderTableView = UITableView()
        folderTableView.translatesAutoresizingMaskIntoConstraints = false
        folderTableView.dataSource = self
        folderTableView.delegate = self
        return folderTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func toAutoLayout() {
        
        view.addSubview(folderTableView)
        
        NSLayoutConstraint.activate([
            
            
            folderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            folderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            folderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            folderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
