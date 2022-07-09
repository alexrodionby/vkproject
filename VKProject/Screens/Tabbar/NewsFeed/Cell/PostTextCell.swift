//
//  PostTextCell.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 8.07.22.
//


import UIKit
import SnapKit

final class PostTextCell: UITableViewCell {
    
    static let identifier = "PostTextCell"

    private let fullTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        fullTextLabel.text = nil
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
        
        if let text = post.text {
            self.fullTextLabel.text = text
        }
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(fullTextLabel)
    }
    
    private func setupConstraints() {

//        NSLayoutConstraint.activate([
//            fullTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: 20),
//            fullTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
//            fullTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            fullTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
        
//        fullTextLabel.snp.makeConstraints { make in
//            make.top.equalTo(contentView).offset(20)
//            make.left.equalTo(contentView).offset(20)
//            make.right.equalTo(contentView).offset(-20)
//            make.bottom.equalTo(contentView).offset(-20)
//        }
        
        fullTextLabel.snp.makeConstraints { make in
//            make.top.equalTo(contentView).inset(20)
//            make.left.equalTo(contentView).inset(20)
//            make.right.equalTo(contentView).inset(20)
//            make.bottom.equalTo(contentView).inset(20)
//
            make.top.left.right.bottom.equalTo(contentView).inset(20)
        }
    }    
}
