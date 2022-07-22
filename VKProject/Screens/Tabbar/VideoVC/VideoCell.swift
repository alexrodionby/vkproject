//
//  VideoCell.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 19.07.22.
//

import UIKit
import WebKit
import SDWebImage
import SnapKit

class VideoCell: UITableViewCell {
        
    static let identifier = "VideoCell"

    let webView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        webView.contentMode = .scaleAspectFit
        webView.clipsToBounds = true
        webView.layer.cornerRadius = 5
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    func configure(_ video: VideoModel) {
        self.titleLabel.text = video.titleVideo
        guard let videoUrl = video.player else {return}
        guard let url = URL(string: videoUrl) else {return}
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(webView)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstrains() {

        webView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(150)
            make.top.left.bottom.equalTo(contentView).inset(7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(webView.snp.right).offset(20)
            make.top.right.bottom.equalTo(contentView).inset(2)
        }
    }
}
