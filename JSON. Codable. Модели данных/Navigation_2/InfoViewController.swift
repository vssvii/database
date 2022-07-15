//
//  InfoViewController.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 12.01.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private enum CellReuseIdentifiers: String {
        case users
        case planets
    }
    
    private lazy var infoTableView: UITableView = {
        let infoTableView = UITableView()
        infoTableView.backgroundColor = .darkGray
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.planets.rawValue)
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        infoTableView.tableFooterView = UIView(frame: .zero)
        return infoTableView
    }()
    
    private lazy var infoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.backgroundColor = .blue
        infoButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        infoButton.layer.shadowRadius = 4
        infoButton.layer.shadowColor = UIColor.black.cgColor
        infoButton.layer.shadowOpacity = 0.7
        infoButton.setTitle("Info", for: .normal)
        infoButton.addTarget(self, action: #selector(buttonInfoAction), for: .touchUpInside)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        return infoButton
    }()
    
    private enum Links {
        static let usersLink = "https://jsonplaceholder.typicode.com/todos/"
        static let planetLink = "https://swapi.dev/api/planets/1"
    }
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    private var users: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        
        setupLayout()
        
        fetchUsers()
        
        fetchPlanetsWithDecoder()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Информация"
    }
    
    private func setupLayout() {
        view.addSubview(infoTableView)
        view.addSubview(infoButton)
        
        NSLayoutConstraint.activate([
            infoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            infoButton.topAnchor.constraint(equalTo: infoTableView.safeAreaLayoutGuide.bottomAnchor),
            infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0)
        ])
    }
    
    @objc func buttonInfoAction(sender: UIButton!) {
        let alertController = UIAlertController(title: "Cообщение!", message: "Прошу нажать один из вариантов!", preferredStyle: .alert)
        let messageAction = UIAlertAction(title: "Вывести сообщение!", style: .default, handler: { action in
            self.showMessage()})
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(messageAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        }
    
    func showMessage() {
        let alertMessage = UIAlertController(title: "Внимание!", message: "Сообщение выявлено!", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertMessage.addAction(alertAction)
        present(alertMessage, animated: true, completion: nil)
    }
    
    private func fetchUsers() {
        guard let url = URL(string: Links.usersLink) else { return }
        
        self.networkService.requestJSON(url: url) { result in
            switch result {
            case .success(let data):
                print("🍏", String(data: data, encoding: .utf8))
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: [])
                    print("🍏", object)
                    if let dictionary = object as? [String: Any] {
                        print("🍏", dump(dictionary))
                    }
                } catch let error {
                    print("🍎", error)
                }
            case .failure(let error):
                print("🍎", error)
            }
        }
    }
    
    private func fetchPlanetsWithDecoder() {
        guard let url = URL(string: Links.planetLink) else { return }

        self.networkService.requestJSON(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let planets = try JSONDecoder().decode(Planets.self, from: data)
                    print("🍏", data)
                    self.infoTableView.reloadData()
                } catch let error {
                    print("🍎", error)
                }
            case .failure(let error):
                print("🍎", error)
            }
        }
    }
}

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.users.rawValue) as! InfoTableViewCell
        cell.userInfoLabel.text = users[indexPath.row]["title"] as? String ?? "Default text"
        return cell
    }
}
