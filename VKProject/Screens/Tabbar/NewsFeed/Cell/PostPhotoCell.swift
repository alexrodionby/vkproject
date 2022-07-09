//
//  PostPhotoCell.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 8.07.22.
//

import UIKit
import SDWebImage
import SnapKit

final class PostPhotoCell: UITableViewCell {
    
    static let identifier = "PostPhotoCell"

    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    func configure(_ post: Post) {
        
        let photoItem = post.photos?.items.last
        
        if let urlString = photoItem?.sizes.last?.url {
            let url = URL(string: urlString)
            self.photoImageView.sd_setImage(with: url)
        }
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {

        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width) //квадратное фото
            make.top.left.right.bottom.equalTo(contentView).inset(0)
        }
    }
}

