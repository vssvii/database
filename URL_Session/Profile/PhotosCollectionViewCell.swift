//
//  PhotosCollectionViewCell.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 05.06.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    
    lazy var photoImageView : UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .black
        photoImageView.layer.cornerRadius = 6
        return photoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        contentView.addSubview(photoImageView)
    }
    
    private func setupLayouts() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
