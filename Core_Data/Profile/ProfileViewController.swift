//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ibragim Assaibuldayev on 05.12.2021.
//

import UIKit
import iOSIntPackage
import SnapKit
import Foundation
import Firebase
import FirebaseAuth
import CoreData

var factory = MyLoginFactory().getLoginInspector()

class ProfileViewController: UIViewController {
    
    private var actionHandler: (() -> Void)?
    
    typealias Callback = () -> Void
    
    let coreManager = CoreDataManager.shared
    
    let userService: UserService?
    
    var userLogIn = LogInViewController(with: factory).login.text
    
    var logInViewController = LogInViewController(with: factory)
    
    init(userService: UserService, userName: String) {
        self.userService = userService
        self.userLogIn = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Post {
        let author: String
        let description: String
        let image: UIImage?
//        let image: String?
        let likes: Int16
        let views: Int16
    }
    
    var posts: [Post] = []
    
    var photos: [Photo] = []
    
    
    private lazy var postTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        return postTableView
    }()
    
    private var profileView: UIView = {
        let profileView = ProfileHeaderView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    private enum CellReuseIdentifiers: String {
        case posts
        case photos
    }
    
    func presentAlert(title: String? = nil, message: String? = nil, completion: (Callback)? = nil) {
        let title = title ?? "Попробуйте снова!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            guard let completion = completion else { return }
            completion()
        }))
        present(alert, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts = [
        Post(author: "Димаш Кудайберген", description: "концерт в Москве", image: UIImage(named: "dimash"), likes: 150, views: 200),
        Post(author: "Elon Musk", description: "Waiting to launch global wi-fi", image: UIImage(named: "starlink"), likes: 400, views: 450),
        Post(author: "Мотивация. Спорт", description: "Программа по отжиманиям", image: UIImage(named: "pushups"), likes: 150, views: 180),
        Post(author: "Фильмы", description: "Аватар 2: Путь воды", image: UIImage(named: "avatar"), likes: 300, views: 400),
        Post(author: "Футбол", description: "Chelsea вышел в финал", image: UIImage(named: "chelsea"), likes: 400, views: 500),
        Post(author: "Путешествия", description: "Щвейцария", image: UIImage(named: "travel"), likes: 450, views: 500)
        ]
        
        photos = [
            Photo(image: UIImage(named: "1")),
            Photo(image: UIImage(named: "2")),
            Photo(image: UIImage(named: "3")),
            Photo(image: UIImage(named: "4"))
        ]


            #if DEBUG
            view.backgroundColor = .systemCyan
            #else
            view.backgroundColor = .systemIndigo
            #endif
        
        view.addSubview(postTableView)
        
        
        NSLayoutConstraint.activate([
            
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.posts.rawValue)
        postTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        
        postTableView.dataSource = self
        postTableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let indexPath = postTableView.indexPathForSelectedRow else { return
        }
        postTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if tableView == postTableView {
            count = 2
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.photos.rawValue) as! PhotosTableViewCell
            cell.rightPointerButton.addTarget(self, action: #selector(goToCollection), for: .touchUpInside)
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.posts.rawValue) as! PostTableViewCell
            cell.authorLabel.text = posts[indexPath.row].author
            cell.descriptionLabel.text = posts[indexPath.row].description
            cell.likesLabel.text = String(posts[indexPath.row].likes)
            cell.viewsLabel.text = String(posts[indexPath.row].views)
            cell.postView.image = posts[indexPath.row].image
          return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let post = posts[indexPath.row]
            let tapRecognizer = TapGestureRecognizer(block: { [self] in
                if coreManager.posts.contains( where: { $0.author == post.author && $0.descript == post.description}) {
                    presentAlert(title: "", message: "Пост уже добавлен!")
                } else {
                    self.coreManager.addNewPost(author: post.author, description: post.description)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
                }
            })
            tapRecognizer.numberOfTapsRequired = 2
            view.addGestureRecognizer(tapRecognizer)
        }
    }
    
    @objc func goToCollection() {
        let photoCollection = PhotosViewController()
        navigationController?.pushViewController(photoCollection, animated: true)
    }
    
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
            
            

class TapGestureRecognizer: UITapGestureRecognizer {
    private var closure: (() -> ())?

    init() {
        super.init(target: TapGestureRecognizer.self, action: #selector(runAction))
        self.removeTarget(TapGestureRecognizer.self, action: #selector(runAction))
        self.addTarget(self, action: #selector(runAction))
    }

    convenience init(block: @escaping (() -> Void)) {
        self.init()
        closure = block
//        view.addGestureRecognizer(self)
    }

    @objc func runAction() {
        print("executed")
        if closure == nil { return }
        closure!()
    }
}
