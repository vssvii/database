//
//  LikedPostsTableViewCell.swift
//  Navigation_2
//
//  Created by Developer on 16.11.2022.
//

import UIKit

class LikedPostsTableViewCell: UITableViewCell {
    
    private lazy var likedImageView: UIImageView = {
        let likedImageView = UIImageView()
        likedImageView.image = UIImage(named: "liked")
        likedImageView.translatesAutoresizingMaskIntoConstraints = false
        return likedImageView
    }()
    
    public lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        
        authorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        
        return authorLabel
    }()
    
    public lazy var descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.textColor = .black
        
        return descriptionLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likedImageView)
        
        NSLayoutConstraint.activate([
            likedImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            likedImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16.0)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16.0),
//            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: likedImageView.trailingAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: likedImageView.trailingAnchor, constant: 16.0),
//            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16.0),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16.0)
        ])
    }
    
    
    public func update(author: String, description: String) {
        authorLabel.text = author
        descriptionLabel.text = description
    }

}
