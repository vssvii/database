//
//  LikedPostsViewController.swift
//  Navigation_2
//
//  Created by Developer on 15.11.2022.
//

import UIKit
import SnapKit

class LikedPostsViewController: UIViewController {
    
    let coreManager = CoreDataManager.shared
    
    private enum CellReuseIdentifiers: String {
        case likedPosts
    }

    
    private lazy var likedPostsTableView: UITableView = {
        let likedPostsTableView = UITableView(frame: .zero, style: .grouped)
        likedPostsTableView.register(LikedPostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.likedPosts.rawValue)
        likedPostsTableView.delegate = self
        likedPostsTableView.dataSource = self
        return likedPostsTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Избранные посты"
        
        view.addSubview(likedPostsTableView)
        
        likedPostsTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if tableView == likedPostsTableView {
            count = 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.likedPosts.rawValue) as! LikedPostsTableViewCell
        let post = coreManager.posts[indexPath.row]
        let imageData = post.image
        let contactImage = UIImage(data: imageData!)
        cell.authorLabel.text = post.author
        cell.descriptionLabel.text = post.descript
        cell.postView.image = contactImage
        cell.likesLabel.text = String(post.likes)
        cell.viewsLabel.text = String(post.views)
        return cell
    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let post = coreManager.posts[indexPath.row]
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(likedPost))
//        view.addGestureRecognizer(tapRecognizer)
//    }
//    
//    @objc func likedPost(indexPath: IndexPath) {
//        let post = coreManager.posts[indexPath.row]
//        coreManager.addNewPost(post: post)
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
            return view
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
                return 200
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 420
        } else {
            return 0
        }
    }
}
