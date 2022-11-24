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
        
        navigationItems()
    }
    
    private func navigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Обновить", style: .done, target: self, action: #selector(update))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Удалить все", style: .plain, target: self, action: #selector(deleteAll))
        navigationItem.leftBarButtonItem?.tintColor = .red
    }
    
    @objc func update() {
        likedPostsTableView.reloadData()
    }
    
    @objc func deleteAll() {
        coreManager.deleteAll()
        likedPostsTableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Любимые посты"
        
        view.addSubview(likedPostsTableView)
        
        likedPostsTableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        var count = 0
//        if tableView == likedPostsTableView {
//            count = 1
//        }
//        return count
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.likedPosts.rawValue) as! LikedPostsTableViewCell
        let post = coreManager.posts[indexPath.row]
        cell.authorLabel.text = post.author
        cell.descriptionLabel.text = post.descript
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = coreManager.posts[indexPath.row]
        let tapRecognizer = TapGestureRecognizer(block: { [self] in
                let alert = UIAlertController(title: "Удаление поста", message: "Вы хотите удалить пост?", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                            //Cancel Action
                        }))
                        alert.addAction(UIAlertAction(title: "Удалить",
                                                      style: UIAlertAction.Style.destructive,
                                                      handler: {(_: UIAlertAction!) in
                            self.coreManager.deletePosts(post: post)
                            tableView.reloadData()
                        }))
                        self.present(alert, animated: true, completion: nil)
        })
        tapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapRecognizer)
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
//        if indexPath.section == 0 {
//                return 200
//        } else {
//            return UITableView.automaticDimension
//        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 420
//        } else {
//            return 0
//        }
//    }
}
