//
//  FriendsView.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 29.06.22.
//

import UIKit

final class FriendsView: UIView {
    
    //MARK: - Public properties
    var onPullToRefreshAction: (()->())?
    
//    lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: UIScreen.main.bounds)
//        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
//
//        return tableView
//    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setupViews() {
        print("private func setupViews()")
//        self.addSubview(tableView)
//        tableView.refreshControl = refreshControl
    }
    
    //MARK: - Actions
    @objc
    func pullToRefreshAction() {
        onPullToRefreshAction?()
    }
}
