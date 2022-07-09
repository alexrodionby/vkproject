//
//  PostLikesCell.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 8.07.22.
//

import UIKit
import SnapKit

final class PostLikesCell: UITableViewCell {
    
    static let identifier = "PostLikesCell"

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        self.likesLabel.text = "♥️ 0"
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
        
        if let likesCount = post.likes?.count {
            self.likesLabel.text = "♥️ \(likesCount)"
        }
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(likesLabel)
    }
    
    private func setupConstraints() {
        likesLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(20)
        }
    }
}

