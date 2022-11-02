//
//  FileManagerTableViewCell.swift
//  FileManager
//
//  Created by Ibragim Assaibuldayev on 01.09.2022.
//

import UIKit
import SnapKit

class FileManagerTableViewCell: UITableViewCell {
    
    private lazy var photoName: UILabel = {
        let photoName = UILabel()
        return photoName
    }()
    
    private var photoImage: UIImageView = {
        let photoImage = UIImageView()
        return photoImage
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(photoName)
        contentView.addSubview(photoImage)
        
        photoName.snp.makeConstraints( { (make) in
            make.top.equalTo(16.0)
            make.leading.equalToSuperview().offset(16.0)
        })
        
        photoImage.snp.makeConstraints( { (make) in
            make.top.equalTo(photoName.snp.bottom)
            make.leading.equalToSuperview().offset(16.0)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
