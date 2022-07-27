//
//  InfoTableViewCell.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 14.07.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    
    public lazy var userInfoLabel: UILabel = {
        let userInfoLabel = UILabel()
        userInfoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        userInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        userInfoLabel.textColor = .black
        userInfoLabel.numberOfLines = 4
        return userInfoLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(userInfoLabel)
        
        NSLayoutConstraint.activate([
            userInfoLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            userInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            userInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0)
        ])
        
        
    }
}
