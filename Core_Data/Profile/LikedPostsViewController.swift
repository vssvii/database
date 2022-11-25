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
    
    private lazy var likedPostsLabel: UILabel = {
        let likedPostsLabel = UILabel()
        likedPostsLabel.textColor = .blue
        likedPostsLabel.text = "2-ое нажатие удаляет пост"
        likedPostsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return likedPostsLabel
    }()

    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshTableView), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    private func navigationItems() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Удалить все", style: .plain, target: self, action: #selector(deleteAll))
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    @objc func refreshTableView() {
        self.likedPostsTableView.reloadData()
    }
    
    @objc func deleteAll() {
        coreManager.deleteAll()
        coreManager.posts = []
        likedPostsTableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Любимые посты"
        
        view.addSubview(likedPostsLabel)
        view.addSubview(likedPostsTableView)
        
        likedPostsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.centerX.equalToSuperview()
        }
        
        likedPostsTableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(likedPostsLabel.snp.bottom).offset(16)
        }
    }
}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
    }
}
