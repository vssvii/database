//
//  PostViewController.swift
//  Navigation
//
//  Created by Ibragim Assaibuldayev on 08.12.2021.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        let feedView = FeedViewController()
//        self.title = feedView.post.title
        
        configureItems()
    }
    
    func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(barButtonAction))
    }
    
    @objc func barButtonAction(sender: UIBarButtonItem!) {
        let infoViewController = InfoViewController()
        navigationController?.pushViewController(infoViewController, animated: true)
    }
    
    
}
