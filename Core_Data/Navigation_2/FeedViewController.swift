//
//  FeedViewController.swift
//  Navigation
//
//  Created by Ibragim Assaibuldayev on 05.12.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    let image = UIImage(named: "feedView")
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
        imageView = UIImageView(frame: CGRect(x: 40, y: 200, width: 300, height: 200))
        imageView.contentMode = .scaleToFill
        imageView.image = image
        view.addSubview(imageView)
        
        let button = UIButton(frame: CGRect(x: 130, y: 500, width: 100, height: 50))
        button.backgroundColor = .systemPurple
        button.setTitle("Post View", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let postViewController = PostViewController()
        postViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(postViewController, animated: true)
    }

//    struct Post {
//    var title: String
//    }
    
//    var post = Post(title: "Пост")
}

