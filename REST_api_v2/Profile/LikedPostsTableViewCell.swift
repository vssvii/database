//
//  LikedPostsTableViewCell.swift
//  Navigation_2
//
//  Created by Developer on 16.11.2022.
//

import UIKit

class LikedPostsTableViewCell: UITableViewCell {

    public lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        
        authorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        
        return authorLabel
    }()
    
    public lazy var postView : UIImageView = {
        let postView = UIImageView()
        postView.translatesAutoresizingMaskIntoConstraints = false
        postView.contentMode = .scaleAspectFill
        postView.backgroundColor = .black
        return postView
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
    
    public lazy var likesLabel : UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.textColor = .black
        
        return likesLabel
    }()
    
    public lazy var viewsLabel : UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        viewsLabel.textColor = .black
        
        return viewsLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(authorLabel)
        contentView.addSubview(postView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30.0),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: authorLabel.safeAreaLayoutGuide.bottomAnchor),
            postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postView.widthAnchor.constraint(equalTo: postView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            descriptionLabel.topAnchor.constraint(equalTo: postView.bottomAnchor, constant: 16.0),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16.0)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16.0),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
        ])
        
        NSLayoutConstraint.activate([
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16.0),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
        ])
    }
    public func update(author: String, description: String, likes: Int, views: Int) {
        authorLabel.text = author
        descriptionLabel.text = description
        likesLabel.text = String(likes)
        viewsLabel.text = String(views)
    }

}
