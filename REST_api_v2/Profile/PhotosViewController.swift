//
//  PhotosViewController.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 07.06.2022.
//

import UIKit
import iOSIntPackage
import Foundation
import SnapKit



class PhotosViewController: UIViewController, UINavigationBarDelegate {
    
    var imagePublisher: ImagePublisherFacade?
    
    private var dataSource: [UIImage]?

    
    let loginInfo = LogInViewController(with: factory)
    
    var photos: [Photo] = []
    
    private enum CellReuseIdentifiers: String {
        case photos
        case collection
    }
    
    private enum LayoutCostant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 300.0
    }
    
    lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .white
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    lazy var photoCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let photoCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        photoCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photoCollectionView.backgroundColor = .white
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.reloadData()
        return photoCollectionView
    }()
    
    let leftBarButtonItem = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: PhotosViewController.self, action: #selector(actionCancelButton))
    
    let navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        photos = [
            Photo(image: UIImage(named: "1")),
            Photo(image: UIImage(named: "2")),
            Photo(image: UIImage(named: "3")),
            Photo(image: UIImage(named: "4")),
            Photo(image: UIImage(named: "5")),
            Photo(image: UIImage(named: "6")),
            Photo(image: UIImage(named: "7")),
            Photo(image: UIImage(named: "8")),
            Photo(image: UIImage(named: "9")),
            Photo(image: UIImage(named: "10")),
            Photo(image: UIImage(named: "11")),
            Photo(image: UIImage(named: "12")),
            Photo(image: UIImage(named: "13")),
            Photo(image: UIImage(named: "14")),
            Photo(image: UIImage(named: "15")),
            Photo(image: UIImage(named: "16")),
            Photo(image: UIImage(named: "17")),
            Photo(image: UIImage(named: "18")),
            Photo(image: UIImage(named: "19")),
            Photo(image: UIImage(named: "20"))
        ]
        
        setupViews()
        setupLayouts()
        
        let navItem = UINavigationItem()
        navItem.title = "Галерея"
        
        navItem.leftBarButtonItem = leftBarButtonItem
        
        navBar.setItems([navItem], animated: true)
        
        imagePublisher?.addImagesWithTimer(time: 10, repeat: 21)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        imagePublisher?.rechargeImageLibrary()
    }
    
    private func setupViews() {
        
        view.addSubview(navBar)
        view.addSubview(photoCollectionView)
    }
    
    
    @objc func actionCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupLayouts() {
        
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            photoCollectionView.topAnchor.constraint(equalTo: navBar.safeAreaLayoutGuide.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
        if let rows = dataSource?.count {
            return rows
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.photos.rawValue, for: indexPath) as! PhotosCollectionViewCell
//        cell.photoImageView.image = photos[indexPath.item].image
//        return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.photos.rawValue, for: indexPath) as! PhotosCollectionViewCell
        if let dataSource = dataSource {
            cell.photoImageView.image = dataSource[indexPath.row]
            return cell
        } else {
            print("Some thing wrong!")
            return cell
        }
    }
}


extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/3)-3,
            height: (view.frame.size.width/3)-3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.8, left: 1, bottom: -8.0, right: -1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension PhotosViewController: ImageLibrarySubscriber {

    func receive(images: [UIImage]) {
        dataSource = images
        
        photoCollectionView.reloadData()
    }
}
